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

ROBOT_CFG="$NM_ROOT/robot/robot.cfg"

ROBOT_ADDRESS="$1"
shift
if [ -z "$ROBOT_ADDRESS" ]
then
cat << EOF
Missing required robot address.
EOF
exit
fi


#echo pu -u "$U" -p "$P" "$HUB_ADDRESS" "$@" >&2
pu -u "$NIM_USERNAME" -p "$NIM_PASSWD" "$ROBOT_ADDRESS" "$@"

exit
##  ## (c) MorseCode Incorporated 2015
