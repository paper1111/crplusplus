#!/usr/bin/bash

# Text color variables
underline=$(tput sgr 0 1)          # Underline
bold=$(tput bold)             # Bold
boldred=${bold}$(tput setaf 1) #  red
boldblue=${bold}$(tput setaf 4) #  blue
boldlimeyellow=${bold}$(tput setaf 190) #  lime yellow
boldgreen=${bold}$(tput setaf 2) # green
reset=$(tput sgr0)             # Reset

echo "${boldgreen}Welcome to the Compiler++ installer!${reset}"

${bold}
echo "  CCCCCC  RRRRR        ++           ++"
echo " CC       R    R       ++           ++"
echo "CC        RRRRR    ++++++++++   ++++++++++"
echo " CC       R    R       ++           ++"
echo "  CCCCCC  R    R       ++           ++"
${reset}

echo "${boldblue}Installing Homebrew...${reset}"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "${boldblue}Done!${reset}"
echo "${boldblue}Checking for problems...${reset}"
brew doctor
echo "${boldlimeyellow}Done!${reset}"

echo "${boldblue}Installing go with homebrew...${reset}"
brew install go --cross-compile-common

echo "${boldblue}Finished, now initalizing parts for gc...${reset}"
mkdir $HOME/go
export GOPATH=$HOME/go

open $HOME/.bash_profile

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

echo "${boldlimeyellow}Finished installing Go!${reset}"
