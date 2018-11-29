#!/bin/bash

client32='lgtoclnt-9.2.1.4-1.i686.rpm'
client64='lgtoclnt-9.2.1.4-1.x86_64.rpm'

hostlist=(list of hosts goes here)
for h in "${hostlist[@]}"
do
	echo $h
	MTYPE=`ssh $h 'uname -m'`
	if [ ${MTYPE} == 'i686' ]; then
		echo '32'
		scp linux_x86/${client32} $h:/tmp/
		ssh $h "rpm -Uvh /tmp/$client32"
        ssh $h "rm /tmp/$client32"
	else
		echo '64'
		scp linux_x86_64/${client64} $h:/tmp/
		ssh $h "rpm -Uvh /tmp/$client64"
        ssh $h "rm /tmp/$client64"
	fi
	ssh $h '/etc/init.d/networker start'
done

