#!/usr/bin/bash
#
# (c) copyright cr++ contributors 2017
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Text color variables
underline=$(tput sgr 0 1)          # Underline
bold=$(tput bold)             # Bold
boldred=${bold}$(tput setaf 1) #  red
boldblue=${bold}$(tput setaf 4) #  blue
boldlimeyellow=${bold}$(tput setaf 190) #  lime yellow
boldgreen=${bold}$(tput setaf 2) # green
reset=$(tput sgr0)             # Reset

# initalization
skipped=()

echo "${boldgreen}Welcome to the Compiler++ installer!${reset}"

echo "${bold}  CCCCCC  RRRRR        ++           ++${reset}"
echo "${bold} CC       R    R       ++           ++${reset}"
echo "${bold}CC        RRRRR    ++++++++++   ++++++++++${reset}"
echo "${bold} CC       R    R       ++           ++${reset}"
echo "${bold}  CCCCCC  R    R       ++           ++${reset}"

echo "${boldblue}Installing Homebrew...${reset}"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "${boldblue}Done!${reset}"
echo "${boldblue}Checking for problems...${reset}"
brew doctor
echo "${boldlimeyellow}Done!${reset}"

######## compiled languages ########
echo "${boldgreen}Installing compilers...${reset}"

echo "${boldblue}Installing Go...${reset}"
echo "Downloading pkg file..."
curl "https://storage.googleapis.com/golang/go1.8.darwin-amd64.pkg" -o "go1.8.darwin-amd64.pkg"
echo "Checking MD5 hash..."
gosha256=$(sha -a 256 go1.8.darwin-amd64.pkg)
if [ $gosha256 == "f9d511eb88baecf8a2e3457bf85eaae73dfb7cade4dd4eaba744947efea586e1" ]; then
       echo "SHA256 of file is $gosha256, validation succeeded"
       echo "Installing..."
       sudo installer -pkg go1.8.darwin-amd64.pkg -target /
       echo "Installed Go!"
else
       echo "SHA256 of file is $gosha256"
       echo "${boldred}SHA is incorrect, skipping installation, please install Go manually!"
       skipped+=("Go")
fi

echo "${boldblue}Installing Clisp from source...${reset}"
echo "Downloading..."
curl "http://ftp.gnu.org/pub/gnu/clisp/release/latest/clisp-2.49.tar.bz2" -o "clisp-2.49.tar.bz2"
echo "Unpacking..."
tar xvjf clisp-2.49.tar.bz2
cd clisp-2.49.tar.bz2
./configure
echo "Compiling..."
make
echo "Installing..."
sudo make install
echo "${boldblue}Succesfully installed Clisp${reset}"

echo "${boldblue}Installing mono...${reset}"
echo "Downloading..."
curl "https://download.mono-project.com/archive/4.8.0/macos-10-universal/MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg" -o "MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg"
echo "Installing..."
sudo installer -pkg MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg
echo "${boldblue}Finished installing mono!"

echo "${boldblue}Installing Fortran... (gfortran)"
echo "Downlaoding..."
curl "http://prdownloads.sourceforge.net/hpc/gfortran-6.3-bin.tar.gz" -o "gfortran-6.3-bin.tar.gz"
echo "Checking md5 hash..."
formd5=$(md5 -q gfortran-6.3-bin.tar.gz)
if [ "$formd5" == "4e0ff4c3c4ec144c484d190a85cea271" ]; then
	echo $formd5
	echo "MD5 hash is valid!"
	echo "Unzipping..."
	gunzip gfortran-6.2-bin.tar.gz
	sudo tar -xvf gfortran-6.2-bin.tar -C /
	echo "${boldblue}Finished installing Fortran!"
else
	echo $formd5
	echo "${boldred}MD5 hash is invalid, skipping installation, please manually install Fortran!${reset}"
  	skipped+=("Fortran")
fi

echo "${boldblue}Installing D...${reset}"
curl -fsS https://dlang.org/install.sh | bash -s dmd
echo "${boldblue}Finished installing D!${reset}"

echo "${boldblue}Installing COBOL (GNU COBOL / Open COBOL)...${reset}"
brew install gnu-cobol
echo "${boldblue}Finsihed installing COBOL!${reset}"

echo "${boldblue}Installing Crystal...${reset}"
brew install crystal-lang
echo "${boldblue}Finished installing Crystal!${reset}"

echo "${boldblue}Installing Rust...${reset}"
curl https://sh.rustup.rs -sSf | sh
echo "${boldblue}Finished installing Rust!${reset}"

######## interpreted languages ########
echo "${boldgreen}Installing non-compiled languages...${reset}"

echo "${boldblue}Installing Python 3...${reset}"
brew install python3
echo "${boldblue}Finished installing Python!${reset}"

echo "${boldblue}Installing R...${reset}"
curl "https://cran.r-project.org/bin/macosx/R-3.3.3.pkg" -o "R-3.3.3.pkg"
echo "Checking md5 hash..."
rmd5=$(md5 -q R-3.3.3.pkg)
if [ "$rmd5" == "893ba010f303e666e19f86e4800f1fbf" ]; then
	echo $rmd5
	echo "MD5 check valid"
  	sudo installer -pkg R-3.3.3.pkg -target /
	echo "${boldblue}Finished insatlling R!${reset}"
else
	echo $rmd5
	echo "${boldred}MD5 hash is invalid, skipping installation, please manually install R!${reset}"
  	skipped+=("R")
fi

echo "${boldblue}Installing Dart...${reset}"
brew tap dart-lang/dart
brew install dart --with-content-shell --with-dartium
echo "${boldblue}Finished installing Dart!${reset}
