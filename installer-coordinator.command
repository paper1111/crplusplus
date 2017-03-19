#!/usr/bin/sh
# File to set up

cd ../..
#curl "" -o "/Library/crplusplus/homebrew-fetch.command"
#curl "" -o "/Library/crplusplus/go-install.command"

osascript <<'ENDASCRIPT'
do shell script "/Library/crplusplus/installer.command" with administrator privileges
log "done!"
ENDASCRIPT
