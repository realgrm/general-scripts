#!/usr/bin/env bash
flatpakfolder="/var/lib/flatpak/exports/bin/"
binfolder="$HOME/.local/bin/"

find $flatpakfolder* | while read flatpakfile; do

    filename=$(basename "$flatpakfile")  

    printf "\nChoose a friendly name to run flatpak application\n(type n to jump to next application or press ctrl+c to cancel script)\n"

    read -p "Application: $filename: " input </dev/tty

    link=$binfolder$input

    if [ $input == "n" ] ; then continue    
    elif [ ! -L "$link" ] ; 
    then
        ln -s $flatpakfile $link
        echo "Linked $flatpakfile to $link"
    else
        echo "Not linked $flatpakfile; link exists"
    fi

done