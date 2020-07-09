#! /usr/bin/env sh

# `loginctl lock-sessions` (plural) requires admin powers,
# and `loginctl lock-session` does not have a user filter option

for SESSION_ID in $(loginctl list-sessions --no-ask-password --output json | jq -r ".[] | select(.user==\"${USER}\") | .session"); do
  loginctl lock-session "${SESSION_ID}"
done

