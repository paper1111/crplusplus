#!/usr/bin/bash

echo "installing homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/paper1111/crplusplus-installer/master/homebrew.rb)"

echo "finished, checking installation..."
brew doctor
