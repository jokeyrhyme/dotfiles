#!/bin/sh
# http://osxdaily.com/2013/01/22/fix-open-with-menu-mac-os-x/
/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user
brew linkapps # this reinstates MacVim, etc
killall Finder
