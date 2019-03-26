device_mac="12-34-56-78-90-10"
logfile="/tmp/watchlock"

# Be sure we don't run second instance
file_recently_touched=$(find /tmp/watchlock -mmin -1 -print)
if [ ! -z "$file_recently_touched" ]
then
	echo "Seems like there is another instance running. Exiting"
	exit
fi

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
	# Avoid CPU crashing loop
	sleep 1
done
} >> /tmp/watchlock
