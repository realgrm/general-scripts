#!/bin/env bash

printf "\ncurrent folder:"

pwd 

printf "command executed: du -h -d 1 2>/dev/null | sort -h
"
echo "
By design errors are hidden
Please wait, this may take a while."

if [ "$EUID" != 0 ]; 
then 
echo "
Running without sudo privileges will skip files that the user doesn't have permission to read
"
else echo ""
fi

du -h -d 1 2>/dev/null | sort -h 

printf "\ncd to a subfolder and rerun script \n\n"
