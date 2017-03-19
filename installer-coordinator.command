#!/usr/bin/sh
# File to set up
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


cd ../..
cd Library
mkdir crplusplus
cd ..
curl "https://raw.githubusercontent.com/paper1111/crplusplus-installer/master/homebrew-fetch.command" -o "/Library/crplusplus/homebrew-fetch.command"
curl "https://raw.githubusercontent.com/paper1111/crplusplus-installer/master/go-installer.command" -o "/Library/crplusplus/go-install.command"

osascript <<'ENDASCRIPT'
do shell script "/Library/crplusplus/homebrew-fetch.command" with administrator privileges
log "done!"
do shell script "/Library/crplusplus/go-installer.command"
log "installing mono..."
do shell script "brew install mono"
log "finished installing mono!"
ENDASCRIPT
