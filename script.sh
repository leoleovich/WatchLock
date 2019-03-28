device_mac="12-34-56-78-90-10"
logfile="/tmp/watchlock"
check_interval=10

# Be sure we don't run second instance
sleep $(echo $RANDOM%10 | bc)
file_recently_touched=$(find $logfile -mmin -1 -print)
if [ ! -z "$file_recently_touched" ]
then
	echo "Seems like there is another instance running. Exiting"
	exit 1
fi
echo "First run" > $logfile

{
locked="NO"
while true
do
	date
	visible=$(/usr/local/bin/blueutil --connect $device_mac || echo NO)
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
		echo "BT device is visible"
		locked="NO"
		sleep $check_interval
	fi
	# Avoid CPU crashing loop
	sleep 0.1
done
} >> $logfile
