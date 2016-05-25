#!/usr/bin/python
import argparse
import subprocess


def split_multi_arg(arg_string):
    arg_array = arg_string.split(":")
    include_arg = [arg for arg in arg_array if "!" not in arg]
    exclude_arg = [arg for arg in arg_array if "!" in arg]
    exclude_arg_stripped = [arg.strip("!") for arg in exclude_arg]
    arg_return = dict()
    if (len(include_arg) > 0):
        arg_return['include'] = include_arg
    if (len(exclude_arg_stripped) > 0):
        arg_return['exclude'] = exclude_arg_stripped
    return (arg_return)


def get_class_name(winid):
    class_name = subprocess.run(['xprop', 'WM_CLASS', '-id', winid], stdout=subprocess.PIPE, universal_newlines=True)
    class_name_cleaned = class_name.stdout.strip().split(',')[0].split(' ')[2].strip('"')
    return(class_name_cleaned)


def get_window_role(winid):
    window_role = subprocess.run(['xprop', 'WM_WINDOW_ROLE', '-id', winid], stdout=subprocess.PIPE, universal_newlines=True)
    window_role_cleaned = window_role.stdout.strip().split(',')[0].split(' ')[2].strip('"')
    return(window_role_cleaned)


def get_title(winid):
    title = subprocess.run(['xtitle', winid], stdout=subprocess.PIPE, universal_newlines=True)
    return(title.stdout.strip())


def filter_wins(arg_list, property_list, filter_value):
    if filter_value == "include":
        property_list = {win_id:property_list[win_id] for win_id in property_list if include_args(arg_list[:], property_list[win_id])}
    if filter_value == "exclude":
        property_list = {win_id:property_list[win_id] for win_id in property_list if exclude_args(arg_list[:], property_list[win_id])}
    return(property_list)

def include_args(arg_list, win_property):
    if len(arg_list) > 0:
        if arg_list[0] in win_property:
            return True
        else:
            del arg_list[-0]
            return include_args(arg_list, win_property)
    else:
        return False

def exclude_args(arg_list, win_property):
    if len(arg_list) > 0:
        if arg_list[0] in win_property:
            return False
        else:
            del arg_list[-0]
            return exclude_args(arg_list, win_property)
    else:
        return True


parser = argparse.ArgumentParser(description="Get window properties to raise")
parser.add_argument('--className')
parser.add_argument('--title')
parser.add_argument('--windowRole')

args = parser.parse_args()

win_id_query = subprocess.run(['bspc', 'query', '-N'], stdout=subprocess.PIPE, universal_newlines=True)
win_id_array = win_id_query.stdout.splitlines()
win_id_filter = [win_id for win_id in win_id_array if "004" not in win_id[2:5]]

class_query = [get_class_name(win_id) for win_id in win_id_filter]
role_query = [get_window_role(win_id) for win_id in win_id_filter]
title_query = [get_title(win_id) for win_id in win_id_filter]

class_list = dict(zip(win_id_filter, class_query))
role_list = dict(zip(win_id_filter, role_query))
title_list = dict(zip(win_id_filter, title_query))

final_win = win_id_filter

if args.title != None and len(final_win) > 1: 
    args_title = split_multi_arg(args.title.replace("'", "").replace('"', ''))
    if 'include' in list(args_title.keys()):
        title_list = filter_wins(args_title['include'], title_list, 'include')
    if 'exclude' in list(args_title.keys()):
        title_list = filter_wins(args_title['exclude'], title_list, 'exclude')
    final_win = [win_id for win_id in final_win if win_id in title_list]

if args.className != None and len(final_win) > 1: 
    args_class = split_multi_arg(args.className.replace("'", "").replace('"', ''))
    if 'include' in list(args_class.keys()):
        class_list = filter_wins(args_class['include'], class_list, 'include')
    if 'exclude' in list(args_class.keys()):
        class_list = filter_wins(args_class['exclude'], class_list, 'exclude')
    final_win = [win_id for win_id in final_win if win_id in class_list]

if args.className != None and len(final_win) > 1: 
    args_class = split_multi_arg(args.className.replace("'", "").replace('"', ''))
    if 'include' in list(args_class.keys()):
        class_list = filter_wins(args_class['include'], class_list, 'include')
    if 'exclude' in list(args_class.keys()):
        class_list = filter_wins(args_class['exclude'], class_list, 'exclude')
    final_win = [win_id for win_id in final_win if win_id in class_list]

if len(final_win) > 0:
    print(final_win[0])
else:
    print('Window not found')
