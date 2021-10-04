#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
WHITE='\033[0;37m'
Yellow='\033[0;33m'
RESET='\033[0m'
sec="5 4 3 2 1 0"
clear
sleep 2
echo -e "${Yellow}Loading In:${RESET}"
for i in $sec;
do
        sleep 1
        if [ $i -ne 0 ]
        then
                echo -e "${WHITE}00:00:0${i}${RESET}"
        else
                echo -e "${GREEN}Loaded${RESET}"
                sleep 10
        fi
done
