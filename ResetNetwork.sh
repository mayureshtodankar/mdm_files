#!/bin/bash
echo "Flushing DNS Caches"
sudo dscacheutil -flushcache
echo "Restarting Network Adapters, this may take a while to complete"
wifi_adapter=$(networksetup -listallhardwareports | grep -A 1 Wi-Fi | grep Device | awk '{print $2}')
mac_address=$(ifconfig $wifi_adapter | grep ether | awk '{print $2}')
echo "Wi-Fi adapter name: $wifi_adapter"
echo "MAC address: $mac_address"
sudo ifconfig $wifi_adapter down
sleep 10
sudo ifconfig $wifi_adapter up
echo "Creating backup directories"
sudo mkdir /Library/Preferences/SystemConfiguration/bkpfiles
echo "Taking backup of files"
sudo cp /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist /Library/Preferences/SystemConfiguration/bkpfiles
sudo cp /Library/Preferences/SystemConfiguration/com.apple.network.identification.plist /Library/Preferences/SystemConfiguration/bkpfiles
sudo cp /Library/Preferences/SystemConfiguration/com.apple.network.eapolclient/configuration.plist /Library/Preferences/SystemConfiguration/bkpfiles
sudo cp /Library/Preferences/SystemConfiguration/com.apple.wifi.message-tracer.plist /Library/Preferences/SystemConfiguration/bkpfiles
sudo cp /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist /Library/Preferences/SystemConfiguration/bkpfiles
sudo cp /Library/Preferences/SystemConfiguration/preferences.plist /Library/Preferences/SystemConfiguration/bkpfiles
echo "Reseting Network"
sudo rm -f /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist
sudo rm -f /Library/Preferences/SystemConfiguration/com.apple.network.identification.plist
sudo rm -f /Library/Preferences/SystemConfiguration/com.apple.network.eapolclient/configuration.plist
sudo rm -f /Library/Preferences/SystemConfiguration/com.apple.wifi.message-tracer.plist
sudo rm -f /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist
sudo rm -f /Library/Preferences/SystemConfiguration/preferences.plist
