#!/bin/bash

DOMAIN="UIM"
U="administrator"
P="*******"
P="this4now"

THISDIR="${0%/*}"
NM_ROOT="/opt/nimsoft"
PATH="$NM_ROOT/bin:$PATH"

cd "$THISDIR"

./list_hubs.sh
for HUB in $(./list_hubs.sh)
do
	if [ "$HUB" != "MORSECODE" ]; then continue; fi

        echo ./list_robots.sh "$HUB"
        ROBOTS=$(./list_robots.sh "$HUB")

        echo "$ROBOTS"| while read ROBOT_NAME
        do

                [ -z "$ROBOT_NAME" ] && continue;

                ROBOT_ADDRESS="$DOMAIN/$HUB/$ROBOT_NAME"
                CDM_ADDRESS="/$DOMAIN/$HUB/$ROBOT_NAME/cdm"
                CONTROLLER_ADDRESS="/$DOMAIN/$HUB/$ROBOT_NAME/controller"

                echo
                echo "$ROBOT_ADDRESS"

		echo
		echo "# Configuring: $ROBOT "

		echo pu -u "$U" -p "$P" "$CONTROLLER_ADDRESS" get_info ""
		INFO=$(pu -u "$U" -p "$P" "$CONTROLLER_ADDRESS" get_info "")
echo "$INFO"


        done

#break  # temporary break to bail after the first hub.

done

exit
