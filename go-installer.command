#!/usr/bin/sh
#
# Script to install Go on the client's machine
#
# (c) copyright cr++ contributers 2017
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

echo "installing go with homebrew..."
brew install go --cross-compile-common

echo "finished, now initalizing parts for gc..."
mkdir $HOME/go
export GOPATH=$HOME/go

open $HOME/.bash_profile

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

echo "finished installing Go!"

