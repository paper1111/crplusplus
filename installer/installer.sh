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
cd
cd ../../Library
mkdir compiler-plus-plus
cd

echo "${boldgreen}Welcome to the Compiler++ installer!${reset}"

echo "${bold}  CCCCCC  RRRRR        ++           ++${reset}"
echo "${bold} CC       R    R       ++           ++${reset}"
echo "${bold}CC        RRRRR    ++++++++++   ++++++++++${reset}"
echo "${bold} CC       R    R       ++           ++${reset}"
echo "${bold}  CCCCCC  R    R       ++           ++${reset}"

######## compiled languages ########
echo "${boldgreen}Installing compilers...${reset}"

echo "${boldblue}Installing Go...${reset}"
echo "Downloading pkg file..."
curl "https://storage.googleapis.com/golang/go1.8.darwin-amd64.pkg" -o "go1.8.darwin-amd64.pkg"
echo "Checking SHA256..."
gosha256=$(shasum -a 256 go1.8.darwin-amd64.pkg)
if [ $gosha256 == "f9d511eb88baecf8a2e3457bf85eaae73dfb7cade4dd4eaba744947efea586e1" ]; then
       echo "SHA256 of file is $gosha256, validation succeeded"
       echo "Installing..."
       sudo installer -pkg go1.8.darwin-amd64.pkg -target /
       echo "${boldblue}Installed Go!${reset}"
else
       echo "SHA256 of file is $gosha256"
       echo "${boldred}SHA is incorrect, skipping installation, please install Go manually!"
       skipped+=("Go")
fi
echo "Cleaning up..."
rm -rf go1.8.darwin-amd64.pkg

echo "${boldblue}Installing mono...${reset}"
echo "Downloading..."
curl "https://download.mono-project.com/archive/4.8.0/macos-10-universal/MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg" -o "MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg"
echo "Installing..."
sudo installer -pkg MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg
echo "Cleaning up..."
rm -rf MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg
echo "${boldblue}Finished installing mono!"

echo "${boldblue}Installing Fortran... (gfortran)"
echo "Downloading..."
curl "http://coudert.name/software/gfortran-6.3-Sierra.dmg" -o "gfortran-6.3-Sierra.dmg"
echo "Attaching..."
hdutil attach gfortran-6.3-Sierra.dmg
echo "Installing..."
sudo installer -pkg /Volumes/gfortran-6.3-Sierra/gfortran.pkg -target /
echo "Cleaning up..."
diskutil unmount /Volumes/gfortran-6.3-Sierra
rm gfortran-6.3-Sierra.dmg
echo "${boldblue}Successfully installed Fortran!${reset}"

echo "${boldblue}Installing D...${reset}"
curl -fsS https://dlang.org/install.sh | bash -s dmd
echo "${boldblue}Finished installing D!${reset}"

echo "${boldblue}Installing Crystal...${reset}"
cd
echo "Downloading tarball..."
curl "https://github.com/crystal-lang/crystal/releases/download/0.21.1/crystal-0.21.1-1-darwin-x86_64.tar.gz" -o "crystal-0.21.1-1-darwin-x86_64.tar.gz"
echo "Unpacking..."
tar xvzf crystal-0.21.1-1-darwin-x86_64.tar.gz
echo "Moving directories..."
mv crystal-0.21.1-1-darwin-x86_64/bin/crystal ../../usr/bin/local
echo "Cleaning up..."
rm -rf crystal-0.21.1-1-darwin-x86_64
echo "${boldblue}Finished installing Crystal!${reset}"

echo "${boldblue}Installing Rust...${reset}"
curl https://sh.rustup.rs -sSf | sh
echo "${boldblue}Finished installing Rust!${reset}"
cd

######## interpreted languages ########
echo "${boldgreen}Installing non-compiled languages...${reset}"

echo "${boldblue}Installing Python 3...${reset}"
echo "Downloading..."
curl "https://www.python.org/ftp/python/3.6.1/python-3.6.1-macosx10.6.pkg" -o "python-3.6.1-macosx10.6.pkg"
echo "Installing..."
sudo installer -pkg python-3.6.1-macosx10.6.pkg -target /
echo "Cleaning up..."
rm -rf python-3.6.1-macosx10.6.pkg
echo "${boldblue}Finished installing Python!${reset}"

echo "${boldblue}Installing R...${reset}"
curl "https://cran.r-project.org/bin/macosx/R-3.3.3.pkg" -o "R-3.3.3.pkg"
echo "Checking md5 hash..."
rmd5=$(md5 -q R-3.3.3.pkg)
if [ "$rmd5" == "893ba010f303e666e19f86e4800f1fbf" ]; then
	echo $rmd5
	echo "MD5 check valid"
  	sudo installer -pkg R-3.3.3.pkg -target /
	echo "Cleaning up..."
	rm -rf R-3.3.3.pkg
	echo "${boldblue}Finished insatlling R!${reset}"
else
	echo $rmd5
	echo "${boldred}MD5 hash is invalid, skipping installation, please manually install R!${reset}"
  	skipped+=("R")
fi

##### main command #####
echo "${boldblue}Installing main scripts...${reset}"
cd
echo "Downloading scripts..."
curl "https://raw.githubusercontent.com/paper1111/crplusplus/master/src/crpp.rb" -o "../../usr/local/bin/crpp"
cd ../../usr/local/bin/
echo "Changing permissions..."
chmod +x crpp
cd
echo "${boldblue}Done!${reset}"

#### Ending ####
echo "${boldlimeyellow}Finished installing Compiler++!${reset}"
