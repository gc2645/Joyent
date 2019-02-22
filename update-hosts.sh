#!/bin/bash

cat ~/Scripts/mystuff.txt
for x in $(cat ~/Scripts/mystuff.txt); 

do 
 echo $x; 
 scp /etc/hosts root@$x:/etc/; 
done;

exit
