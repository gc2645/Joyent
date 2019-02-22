#!/bin/bash

# Create machines with Debian7-Get Image
for i in `seq 1 1`;
do
	sdc-createmachine --image=f7c3fa5a-a373-6eb5-b7bc-ab21e0828030 --package=8b2288b6-efcf-4e20-df2c-e6ad6219b501 2> /dev/null |json -ag id 
	sleep 10s
done

exit
