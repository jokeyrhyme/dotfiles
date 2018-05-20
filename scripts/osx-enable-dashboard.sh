#!/bin/sh
# http://osxdaily.com/2007/03/14/how-to-completely-disable-dashboard/
defaults write com.apple.dashboard mcx-disabled -boolean NO
killall Dock
