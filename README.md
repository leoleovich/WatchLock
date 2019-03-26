# Setup
* Get brew - https://brew.sh
* brew install blueutil
* Check devices around. Be sure to find your device:
```
blueutil --inquiry
```
This should show your device with mac address looking like this: "12-34-56-78-90-12"
* (Optional) connect and pair your device:
```
blueutil --connect <mac>
blueutil --pair <mac>
```
* edit script.sh and replace mac address with the one from output above
* Run it. Check the logfile (/tmp/watchlock). Be sure it works
* Automtor - New - Application - Run shell script. Paste content of script.sh there. Save to /Applications
* System Preferences - User & Groups - Login Items - Add
