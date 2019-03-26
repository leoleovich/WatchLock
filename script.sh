# Set Mac address of your device here!
device_mac="12-34-56-78-90-12"
{
locked="NO"
while true
do
	date
	visible=$(/usr/local/bin/blueutil --inquiry 10 | grep $device_mac  || echo NO)
	if [ "$visible" == "NO" ]
	then
		echo "BT device disappeared"
		if [ "$locked" == "NO" ]
		then
			echo "locking"
			locked="YES"
			/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine
		fi
	else
		echo $visible
		echo "BT device is visible"
		locked="NO"
	fi
done
} >> /tmp/btlock
