#!/bin/bash

#Delete All VM's in Default Data Center

# Stop all machines
for i in $(sdc-listmachines 2> /dev/null | json -ag id)
do
	echo "Stopping Machine: " $i
	sdc-stopmachine $i 2> /dev/null
done

sleep 10m

# Delete all machines
for i in $(sdc-listmachines 2> /dev/null | json -ag id)
do
	echo "Delete Machine: " $i
        sdc-deletemachine $i 2> /dev/null
done

exit
