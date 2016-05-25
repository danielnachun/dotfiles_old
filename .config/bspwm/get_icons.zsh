#!/usr/bin/zsh

. $(dirname $0)/lemonbar_config.sh
desktop=$1

wm_ids=$(bspc query -N -d $desktop -n .normal)
wm_classes=($(foreach win_id ($(echo $wm_ids)) sed 's/"//g' <<< $(cut -d ' ' -f 4 <<< $(xprop WM_CLASS -id $win_id)); end))
wm_titles=$(foreach win_id ($(echo $wm_ids)) xtitle $win_id; end)

#foreach wm_index ({1..${#wm_classes}}) 
    #case $wm_classes[(w)$wm_index] in
        #google-chrome*)
            #echo "%{T2}${icon_chrome}%{T1} "
            #;;
    #esac
#end

icon_out=""
foreach wm_index ({1..${#wm_classes}}) 
    wm_current=$wm_classes[(f)$wm_index]
    case $wm_current in
        google-chrome*)
            wm_title=$wm_titles[(f)$wm_index]
            icon_out="${icon_out}"
            case $wm_title in
                'Google Keep')
                    icon_out="${icon_out}%{T2}${icon_notes}%{T1} " 
                    ;;
                'Google Hangouts')
                    icon_out="${icon_out}%{T2}${icon_hangouts}%{T1} " 
                    ;;
                *)
                    icon_out="${icon_out}%{T2}${icon_chrome}%{T1} "
                    ;;
            esac
            ;;
    esac
end

echo $icon_out
