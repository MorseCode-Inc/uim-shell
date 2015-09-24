#!/bin/bash

BINDIR="${0%/*}"

if [ -f "$BINDIR/common.rc" ]
then
	. "$BINDIR/common.rc"
else
cat << EOF
Missing required common.rc file, re-install to fix.
File location: $PWD/common.rc
EOF
exit
fi

if [ -f "$BINDIR/nimbus.rc" ]
then
. "$BINDIR/nimbus.rc"
else
cd "$BINDIR"
cat << EOF
Missing required nimbus.rc file.  Expected to contain the following:

NIM_USERNAME="administrator"
NIM_PASSWD="******"

File location: $PWD/nimbus.rc
EOF
exit
fi

HUB_COMMAND="$PWD/hub_command.sh"
HUB="$1"

#echo $HUB_COMMAND "$HUB" getrobots "" "" >&2
DATA=$($HUB_COMMAND "$HUB" getrobots "" "")
#echo "data: $DATA"

echo "$DATA" | grep name | awk '{print $4}'

exit
##  ## (c) MorseCode Incorporated 2015
