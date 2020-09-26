#! /usr/bin/env sh

makoctl reload

notify-send --urgency=low --app-name=networkmanager --icon=network-wireless-connected 'My Wi-Fi Network' 'Connected'

# TODO: copy metadata from real Slack notifications
notify-send --urgency=normal --app-name=slack 'Kermit the Frog' "It ain't easy being green"

notify-send --urgency=critical --icon=face-worried 'this is fine' 'everything is on fire'

notify-send --urgency=critical --app-name=linux --icon=software-update-urgent 'Software Update' 'I simply must have the latest model!'
