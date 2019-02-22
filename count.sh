#!/bin/bash

# Shitty manta count someting scrpt.  
# Doesnt seem to work...


MANTA_KEY_ID=d5:ee:fc:58:fd:25:d2:55:38:4b:b8:96:d1:7f:a4:0a
MANTA_URL=https://us-east.manta.joyent.com
MANTA_USER=greg.cox

manta ()
{
    local alg = rsa - sha256;
    local keyId = /$MANTA_USER/keys / $MANTA_KEY_ID;
    local now = $(date - u "+%a, %d %h %Y %H:%M:%S GMT");
    local sig = $(echo "date:" $now |     tr - d '\n' |     openssl dgst - sha256 - sign $HOME / .ssh / id_rsa |     openssl enc - e - a | tr - d '\n');
    curl - sS $MANTA_URL "$@" - H "date: $now"\ - H "Authorization: Signature keyId=\"$keyId\",algorithm=\"$alg\",signature=\"$sig\""
}


for i in 01 02 03 04 05 06 07 08 09 10 11 12;
do
	filename=$(mls /admin/stor/sdc/cnapi_servers/$1/2015/$i/25/01/)
	totalram=0
	for cnram in $(mget -q /admin/stor/sdc/cnapi_servers/$1/2015/$i/25/01/$filename | json -Hag ram)
	do
#		echo $cnram
		totalram=$((totalram+cnram))
#		echo $totalram
	done

echo $totalram
done

exit
