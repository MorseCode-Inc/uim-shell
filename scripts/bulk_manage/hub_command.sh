#!/bin/bash

NM_ROOT="/opt/nimsoft"

PATH="$NM_ROOT/bin:$PATH"

U="administrator"
P="*********"
U="administrator"
P="this4now"

HUBS="
#Name|Address|Security|Status|License|Version|IP|Communication Mode|Port|Domain|Robot
Jonathan|/UIM/Jonathan/l01-marks/hub|Enabled|OK|OK|7.63 [Build 7.63.2771, Dec 10 2014]|192.168.2.109||48002|UIM|l01-marks
LGMT01|/UIM/LGMT01/jhaynes-pc/hub|Enabled|OK|OK|7.63 [Build 7.63.2771, Dec 10 2014]|10.0.8.29||48002|UIM|jhaynes-pc
MORSECODE|/UIM/MORSECODE/_hub/hub|Enabled|OK|OK|7.63 [Build 7.63.2771, Dec 10 2014]|162.248.167.44||48002|UIM|_hub
redfish|/UIM/redfish/_hub/hub|Enabled|Error|OK|7.63 [Build 7.63.2771, Dec 10 2014]|10.14.47.129||48002|UIM|_hub
vmw701|/UIM/vmw701/vmw701/hub|Enabled|OK|OK|7.63 [Build 7.63.2771, Dec 10 2014]|192.168.1.110||48002|UIM|vmw701
"

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


echo pu -u "$U" -p "$P" "$HUB_ADDRESS" "$@" >&2
pu -u "$U" -p "$P" "$HUB_ADDRESS" "$@"

exit
