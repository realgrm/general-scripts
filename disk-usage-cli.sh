#!/bin/env bash

printf "\ncurrent folder:"

pwd 

printf "command executed: du -h -d 1 \| sort -h \n\nRunning without sudo will skip files without permission \nBy design errors are hidden \nPlease wait, this may take a while. \n\n"

du -h -d 1 2>/dev/null | sort -h 

printf "\ncd to a subfolder and rerun script \n\n"
