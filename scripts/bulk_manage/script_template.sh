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

THISDIR="${0%/*}"
NM_ROOT="/opt/nimsoft"
PATH="$NM_ROOT/bin:$PATH"

FIELDS="os_user1
os_user2
origin"

INCLUDE_LIKE="CLOUD"
PROBE_TO_REMOVE="dirscan"

cd "$THISDIR"
HUB_CMD="$PWD/hub_command.sh"
ROBOT_CMD="$PWD/robot_command.sh"

for HUB in $(./list_hubs.sh)
do
	if [ "$HUB" != "MORSECODE" ]; then continue; fi

        ROBOTS=$(./list_robots.sh "$HUB")

        echo "$ROBOTS"| while read ROBOT_NAME
        do

		ROBOT="$ROBOT_NAME"
                [ -z "$ROBOT_NAME" ] && continue;

                ROBOT_ADDRESS="/$DOMAIN/$HUB/$ROBOT_NAME"
                CDM_ADDRESS="/$DOMAIN/$HUB/$ROBOT_NAME/cdm"
                CONTROLLER_ADDRESS="/$DOMAIN/$HUB/$ROBOT_NAME/controller"

		#echo $ROBOT_CMD "$CONTROLLER_ADDRESS" get_info ""
		DATA=$($ROBOT_CMD "$CONTROLLER_ADDRESS" get_info "" | fgrep "$FIELDS" | awk '{print $1" "$4}')

		echo "$DATA" | while read NAME VALUE
		do
			MATCH=$(echo "$VALUE" | grep "$INCLUDE_LIKE")
			if [ -n "$MATCH" ]
			then
				## match
				echo
				echo " + $ROBOT ($NAME=$MATCH)"

				$PWD/uninstall_probe.sh $ROBOT_ADDRESS "$PROBE_TO_REMOVE"
				
				break;
			fi
		done

		#INFO=$(pu -u "$U" -p "$P" "$CONTROLLER_ADDRESS" get_info "")


        done

#break  # temporary break to bail after the first hub.

done

exit
