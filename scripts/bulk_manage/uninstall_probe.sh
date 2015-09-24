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

#!/bin/bash

##
## Uninstall Probe
##

if [ -z "$1" ] || [ -z "$2" ]
then
cat << EOF
Usage:
$0 robot probe

robot = the robot address: /DOMAIN/HUB/ROBOT
probe = the probe to uninstall

EOF
fi

HUB_COMMAND="$PWD/hub_command.sh"
ROBOT_COMMAND="$PWD/robot_command.sh"

$ROBOT_COMMAND "$1" inst_pkg_remove "$2"

echo "$DATA" | grep name | grep -v robotname | awk '{print $4}'
exit
##  ## (c) MorseCode Incorporated 2015
