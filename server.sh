#!/bin/bash



PORT=6967
socat -b100000 TCP4-LISTEN:$PORT,reuseaddr,fork EXEC:"./handle_req.sh"
