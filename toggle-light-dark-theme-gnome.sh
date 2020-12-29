#!/usr/bin/env bash
if [ $(gsettings get org.gnome.desktop.interface gtk-theme) == "'Adwaita-dark'" ];
then
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
else
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
fi
