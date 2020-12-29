#!/bin/env bash

printf "\ncurrent folder:"

pwd 

printf "command executed: du -h -d 1 \| sort -h

Running without sudo will skip files without permission
By design errors are hidden
Please wait, this may take a while.

"

du -h -d 1 2>/dev/null | sort -h 

printf "\ncd to a subfolder and rerun script \n\n"
