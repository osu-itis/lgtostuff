#!/bin/bash

hostlist=(list of hosts goes here)

for h in "${hostlist[@]}"
do
    echo $h
	ssh $h "strings /usr/sbin/save | grep '@(#) Release'"
done

