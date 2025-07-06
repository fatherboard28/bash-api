#!/bin/bash

HEADER="Content-Type:application/json"
DATA='{"key1": "value1", "key2": "value2"}'
#-d $DATA
curl -X GET -H $HEADER localhost:6967/silly
