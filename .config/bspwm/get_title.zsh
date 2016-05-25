#!/usr/bin/zsh

focused_id=$(bspc query -N -n)
title=$(xtitle $focused_id)

echo TITLE$title
