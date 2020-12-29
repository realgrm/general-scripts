#!/bin/bash

#Override flatpak theme. In example the app Geary ("org.gnome.Geary")
flatpak override --user --filesystem=~/.themes:ro org.gnome.Geary
