#!/usr/bin/zsh

sed -i 's/GtkScrollbar::has-backward-stepper = 0/GtkScrollbar::has-backward-stepper = 1/g' /usr/share/themes/Arc-Dark/gtk-2.0/main.rc
sed -i 's/GtkScrollbar::has-forward-stepper = 0/GtkScrollbar::has-forward-stepper = 1/g' /usr/share/themes/Arc-Dark/gtk-2.0/main.rc
sed -i 's/GtkRange::stepper-size = 0/GtkRange::stepper-size = 8/g' /usr/share/themes/Arc-Dark/gtk-2.0/main.rc
sed -i 's/GtkScrollbar::stepper-size = 0/GtkScrollbar::stepper-size = 8/g' /usr/share/themes/Arc-Dark/gtk-2.0/main.rc

sed -i 's/GtkScrollbar::has-backward-stepper = 0/GtkScrollbar::has-backward-stepper = 1/g' /usr/share/themes/Vertex-Dark/gtk-2.0/gtkrc
sed -i 's/GtkScrollbar::has-forward-stepper = 0/GtkScrollbar::has-forward-stepper = 1/g' /usr/share/themes/Vertex-Dark/gtk-2.0/gtkrc
sed -i 's/GtkRange::stepper-size = 0/GtkRange::stepper-size = 8/g' /usr/share/themes/Vertex-Dark/gtk-2.0/gtkrc
sed -i 's/GtkScrollbar::stepper-size = 0/GtkScrollbar::stepper-size = 8/g' /usr/share/themes/Vertex-Dark/gtk-2.0/gtkrc
