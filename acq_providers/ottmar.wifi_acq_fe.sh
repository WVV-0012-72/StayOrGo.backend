#!/bin/bash
if [[ $# != 1 ]]; then
	echo "must supply host, e.g. pi-box-04"
	exit
fi;

HOST=$1

echo "connecting to ACQ FE $HOST"

while true; do
	DWEET=$(curl https://dweet.io/get/latest/dweet/for/$HOST 2>/dev/null)
	echo "$DWEET"
	sleep 2
done;
