#!/bin/bash
extensions=$(gsettings get org.gnome.shell enabled-extensions)
sed 's/^soft-brightness@fifi.org://' $extensions