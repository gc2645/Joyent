#!/bin/bash

#Obviously lists vm's in each data center...


export ams1="https://eu-ams-1.api.joyentcloud.com"
export east1="https://us-east-1.api.joyentcloud.com"
export east2="https://us-east-2.api.joyentcloud.com"
export east3="https://us-east-3.api.joyentcloud.com"
export east3b="https://us-east-3b.api.joyentcloud.com"
export sw1="https://us-sw-1.api.joyentcloud.com"
export west1="https://us-west-1.api.joyentcloud.com"

for location in $ams1 $east1 $east2 $east3 $east3b $sw1 $west1;
 do
	echo "Fetching Maching list from $location"
	sdc-listmachines --url $location 2> /dev/null|json -Hag id
 done

exit
