#!/bin/bash

# Get the current date in seconds since epoch
current_date=$(date +%s)

# Get the password expiration date in seconds since epoch
expiration_date=$(dscl . -read /Users/$(whoami) | grep -A 1 "passwordLastSetTime" | tail -n 1 |  awk -F'<real>|</real>' '/<real>/ {printf "%.0f\n", $2}')

# Calculate the number of days until password expiration
days_until_expire=$((($expiration_date - $current_date) / 86400))

# Threshold for prompting user (in days)
threshold=53

echo $days_until_expire

if [[ $days_until_expire > $threshold ]]; then
    # Prompt the user to change password
    output=$(osascript -e 'display dialog "Your laptop login password will expire in '$days_until_expire' days. To prevent lockout, please ensure you change it before it expires by restarting your system. " buttons {"OK", "Contact IT Team"} default button "OK" with title "Laptop Password Expiry" with icon POSIX file "/System/Applications/Utilities/Keychain Access.app/Contents/Resources/AppIcon.icns"')
    if [ "$output" = "button returned:OK" ]; then
        echo "User clicked OK"
    else
        echo "User clicked Contact IT Team"
        open "https://curvetomorrow.freshservice.com/support/catalog/items/108"
    fi
fi
