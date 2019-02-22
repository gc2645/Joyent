#!/bin/bash

AMS1="https://eu-ams-1.api.joyentcloud.com"
EAST1="https://us-east-1.api.joyentcloud.com"
EAST2="https://us-east-2.api.joyentcloud.com"
EAST3="https://us-east-3.api.joyentcloud.com"
SW1="https://us-sw-1.api.joyentcloud.com"
WEST1="https://us-west-1.api.joyentcloud.com"

# Create machines with Debian7-Get Image
#for i in `seq 1 100`;
#do

	echo " "	
	echo "Calling Joyent CloudAPI"	

	MachineID="$(sdc-createmachine --url https://us-east-3b.api.joyentcloud.com --image=5a0145ee-15c4-11e5-9c49-ef53e8760a7e --package=46509ae4-67bf-6422-bf56-9d91de1f3a81 2> /dev/null |json -ag id)"
	echo "Creating Machine: $MachineID"

	sleep 20s

	IPaddr="$(sdc-listmachines --url https://us-east-3b.api.joyentcloud.com 2> /dev/null |json -ag id ips[0] |grep $MachineID |cut -d " " -f 2)" 
	echo "Booting with IP Address: $IPaddr"

	sleep 20s

	ssh -o "StrictHostKeyChecking no" root@$IPaddr apt-get update > /dev/null 2>&1
	echo "Getting Updates"

	ssh -o "StrictHostKeyChecking no" root@$IPaddr apt-get -y install wget > /dev/null 2>&1
	echo "Getting wget"

	ssh -o "StrictHostKeyChecking no" root@$IPaddr wget --no-check-certificate http://smartos.org 2> /tmp/$MachineID-smartos.org
	SmartOS="$(grep index /tmp/$MachineID-smartos.org|grep -v Sav)"
	echo "Downloaded SmartOS.org  $SmartOS"
	echo "$IPaddr $MachineID Downloaded SmartOS.org    $SmartOS">> Wget-Fun.log
	
	ssh -o "StrictHostKeyChecking no" root@$IPaddr wget --no-check-certificate http://elementary.io 2> /tmp/$MachineID-elementary.io
	ElementaryOS="$(grep index /tmp/$MachineID-elementary.io |grep -v Sav)"
	echo "Downloaded Elemenary.io  $ElementaryOS"
	echo "$IPaddr $MachineID Downloaded Elementary.io  $ElementaryOS">> Wget-Fun.log
	rm /tmp/$MachineID*	

	sdc-stopmachine $MachineID --url https://us-west-1.api.joyentcloud.com 2> /dev/null
	echo "Stopping Machine: $MachineID"

	sleep 60s
	
	sdc-deletemachine $MachineID --url https://us-west-1.api.joyentcloud.com 2> /dev/null
	echo "Deleting Machine: $MachineID"

#done

#sleep 20m

# Stop all machines
#for i in $(sdc-listmachines 2> /dev/null | json -ag id)
#do
#	echo "Stopping Machine: " $i
#	sdc-stopmachine $i 2> /dev/null
#done

#sleep 10m

# Delete all machines
#for i in $(sdc-listmachines 2> /dev/null | json -ag id)
#do
#	echo "Delete Machine: " $i
#        sdc-deletemachine $i 2> /dev/null
#done

#sleep 10m

exit
