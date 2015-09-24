#!/bin/bash

## List Robots ## (c) MorseCode Incorporated 2015
##
## List the Robots in your UIM environment.
##

HUB_COMMAND="$PWD/hub_command.sh"
HUB="$1"

echo $HUB_COMMAND "$HUB" getrobots "" "" >&2
DATA=$($HUB_COMMAND "$HUB" getrobots "" "")
#echo "data: $DATA"

echo "$DATA" | grep name | awk '{print $4}'

exit
