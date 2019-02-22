
for ams in $(sdc-listmachines --url https://eu-ams-1.api.joyentcloud.com |json -ag ips[0]); 
 do 
	echo $ams $1
	ssh -o "StrictHostKeyChecking no" root@$ams $1 &
 done;

for east in $(sdc-listmachines --url https:/us-east-1.api.joyentcloud.com |json -ag ips[0]);
 do
	echo $east $1
        ssh -o "StrictHostKeyChecking no" root@$east $1 &
 done;

for sw in $(sdc-listmachines --url https://us-sw-1.api.joyentcloud.com |json -ag ips[0]);
 do
	echo $sw $1
        ssh -o "StrictHostKeyChecking no" root@$sw $1 & 
 done;
