#!/bin/bash

client32='lgtoclnt_9.2.1.4_i386.deb'
client64='lgtoclnt_9.2.1.4_amd64.deb'

hostlist=(list of hosts goes here)
for h in "${hostlist[@]}"
do
	echo $h
	MTYPE=`ssh $h 'uname -m'`
	if [ ${MTYPE} == 'i686' ]; then
		echo '32'
		scp linux_x86/${client32} $h:/tmp/
		ssh $h "dpkg -i /tmp/$client32"
		ssh $h 'apt-get -f install'
	else
		echo '64'
		scp linux_x86_64/${client64} $h:/tmp/
		ssh $h "dpkg -i /tmp/$client64"
		ssh $h 'apt-get -f install'
	fi
	ssh $h '/etc/init.d/networker start'
done

