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

HUB="$1"
if [ -z "$HUB" ]
then
        HUBROBOT=$(grep hubrobotname "$ROBOT_CFG" | sed -e "s/.* = //g")
        HUB=$(grep "hub = " "$ROBOT_CFG" | sed -e "s/.* = //g")
        shift
else
        HUB_INFO=$(echo "$HUBS" | grep "^$HUB|")
        if [ -z "$HUB_INFO" ]
        then
                HUBROBOT=$(grep hubrobotname "$ROBOT_CFG" | sed -e "s/.* = //g")
                HUB=$(grep "hub = " "$ROBOT_CFG" | sed -e "s/.* = //g")
        else
                shift
        fi
fi


# get the hub for the current robot
HUB_INFO=$(echo "$HUBS" | grep "^$HUB|")

HUB_NAME="${HUB_INFO%%|*}"; HUB_INFO="${HUB_INFO#*\|}"
HUB_ADDRESS="${HUB_INFO%%|*}"; HUB_INFO="${HUB_INFO#*|}"
HUB_SECURITY="${HUB_INFO%%|*}"; HUB_INFO="${HUB_INFO#*|}"
HUB_STATUS="${HUB_INFO%%|*}"; HUB_INFO="${HUB_INFO#*|}"
HUB_LICENSE="${HUB_INFO%%|*}"; HUB_INFO="${HUB_INFO#*|}"
HUB_VERSION="${HUB_INFO%%|*}"; HUB_INFO="${HUB_INFO#*|}"
HUB_IP="${HUB_INFO%%|*}"; HUB_INFO="${HUB_INFO#*|}"
HUB_MODE="${HUB_INFO%%|*}"; HUB_INFO="${HUB_INFO#*|}"
HUB_PORT="${HUB_INFO%%|*}"; HUB_INFO="${HUB_INFO#*|}"
HUB_DOMAIN="${HUB_INFO%%|*}"; HUB_INFO="${HUB_INFO#*|}"
HUB_ROBOT="${HUB_INFO%%|*}"; HUB_INFO="${HUB_INFO#*|}"


#echo pu -u "$U" -p "$P" "$HUB_ADDRESS" "$@" >&2
pu -u "$NIM_USERNAME" -p "$NIM_PASSWD" "$HUB_ADDRESS" "$@"

exit
##  ## (c) MorseCode Incorporated 2015
