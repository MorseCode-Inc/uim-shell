#!/bin/bash

## List Hubs ## (c) MorseCode Incorporated 2015
##
## List the hubs in your UIM environment.
##

HUB_COMMAND="$PWD/hub_command.sh"

HUB="$1"
#echo $HUB_COMMAND "$HUB" gethubs "" ""
#$HUB_COMMAND "$HUB" gethubs "" ""
DATA=$($HUB_COMMAND "$HUB" gethubs "" "")
echo "$DATA" | grep name | grep -v robotname | awk '{print $4}'
exit
