#!/bin/bash

#myArray=("apple" "banana" "cherry" "date" "elderberry")
#for value in ./../*
#do
#  echo $value
#done
##echo "Now, number is $number"
#
#_admin_ip="202.54.1.33|MUM_VPN_GATEWAY 23.1.2.3|DEL_VPN_GATEWAY 13.1.2.3|SG_VPN_GATEWAY"
#for e in $_admin_ip
#do
#  echo $e
#done

#read -p "What is your name?" NAME

#for value in $@
#do
#  echo "Hello" $value
#done

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m' # Reset color

function getFilesList() {
  local directory="$1"
  local indent="$2"

  # Loop through each item in the directory
  for item in "$directory"/*; do
    # Check if the item is a file
    if [ -f "$item" ]; then
      echo -e "${YELLOW}${indent} $(basename "$item")${RESET}"
    fi

    # Check if the item is a directory
    if [ -d "$item" ]; then
      echo -e "${GREEN}${indent} $(basename "$item")${RESET}"
      # Recursively call the function for subdirectories
      getFilesList "$item" "----$indent"
    fi
  done
}

getFilesList $@

function print_age(){
  read -p "What is your birth year? " BIRTH_YEAR

  CURRENT_YEAR=`date +%Y`
  AGE=$((CURRENT_YEAR - BIRTH_YEAR))
  echo -e "Your age is : $AGE"
}

print_age