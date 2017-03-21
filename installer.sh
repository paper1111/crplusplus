#!/usr/bin/bash

# Text color variables
underline=$(tput sgr 0 1)          # Underline
bold=$(tput bold)             # Bold
boldred=${bold}$(tput setaf 1) #  red
boldblue=${bold}$(tput setaf 4) #  blue
boldwhite=${bold}$(tput setaf 7) #  white
boldgreen=${bold}$(tput setaf 2) # green
reset=$(tput sgr0)             # Reset
