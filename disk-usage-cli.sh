#!/bin/env bash

printf "du -h -d 1 \| sort -h \n"
pwd 
du -h -d 1 | sort -h
