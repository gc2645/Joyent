#!/bin/bash

export ams1="https://eu-ams-1.api.joyentcloud.com"
export east1="https://us-east-1.api.joyentcloud.com"
export east2="https://us-east-2.api.joyentcloud.com"
export east3="https://us-east-3.api.joyentcloud.com"
export east3b="https://us-east-3b.api.joyentcloud.com"
export sw1="https://us-sw-1.api.joyentcloud.com"
export west1="https://us-west-1.api.joyentcloud.com"

echo "Fetching Maching list from $ams1"
for cn in $(sdc-listmachines --url $ams1 2>/dev/null |json -ag ips[0])
 do
        echo "Executing Commands on Machine: $cn"
        ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump https://smartos.org > /dev/null 2>&1 &
	ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump http://elementary.io > /dev/null 2>&1 &
	ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump http://wiki.smartos.org/display/DOC/Download+SmartOS > /dev/null 2>&1 &
 	ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump http://www.archbang.org/ > /dev/null 2>&1 &
	ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump http://www.debian.org/ > /dev/null 2>&1 &
 done

sleep 30s

echo "Fetching Maching list from $east1"
for cn in $(sdc-listmachines --url $east1 2>/dev/null |json -ag ips[0])
 do
	echo "Executing Commands on Machine: $cn"
        ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump https://smartos.org > /dev/null 2>&1 &
        ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump http://archlinux.org > /dev/null 2>&1 &
        ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump http://alpinelinux.org > /dev/null 2>&1 & 
done;

sleep 30s

echo "Fetching Maching list from $east3b"
for cn in $(sdc-listmachines --url $east3b 2>/dev/null |json -ag ips[0])
 do
        echo "Executing Commands on Machine: $cn"
        ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump https://smartos.org > /dev/null 2>&1 &
        ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump http://archlinux.org > /dev/null 2>&1 &
        ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump http://alpinelinux.org > /dev/null 2>&1 &
 done;

sleep 30s

echo "Fetching Machine list from $sw1"
for cn in $(sdc-listmachines --url $sw1 2>/dev/null |json -ag ips[0])
 do
        echo "Executing Commands on Machine: $cn"
        ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump https://smartos.org > /dev/null 2>&1 &
        ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump http://archlinux.org > /dev/null 2>&1 &
        ssh -o "StrictHostKeyChecking no" root@$cn lynx --dump http://alpinelinux.org > /dev/null 2>&1 &
done;

exit
