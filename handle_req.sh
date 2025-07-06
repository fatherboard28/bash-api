#!/bin/bash

read -r request_line
echo "$(date) Request line: $request_line" >> logs

request_type=$(echo "$request_line" | sed 's/.*\(GET\).*\/\(.*\) H.*/\1/')
path=$(echo "$request_line" | sed 's/.*\(GET\).*\/\(.*\) H.*/\2/')
echo "$(date) Request info: $request_type $path" >> logs

while IFS= read -r line; do
  printf "$(date) Received: $line\n" >> logs
  if [[ ${#line} -eq 1 ]]; then
    break
  fi
done

CONTENT=""

if [[ "$path" == "" ]]; then
  HEAD_ELEMENTS="<link rel=\"stylesheet\" href=\"./styles.css\">"
  HEAD="<head>$HEAD_ELEMENTS</head>"
  BODY="<body>Hello From the epic server </body>"
  CONTENT="<html>$HEAD$BODY</html>"
  CONTENT_TYPE="text/html"
fi
if [[ "$path" == "silly" ]]; then
  HEAD_ELEMENTS=""
  HEAD="<head>$HEAD_ELEMENTS</head>"
  BODY="<body>You have found the silly route</body>"
  CONTENT="<html>$HEAD$BODY</html>"
  CONTENT_TYPE="text/html"
fi
if [[ "$path" == "styles.css" ]]; then
  CONTENT=$(cat styles.css)
  CONTENT_TYPE="text/css"
fi

DATE=$(date)
SERVER="Themostepicserver"

echo -en "HTTP/1.1 200 OK\\r\\nServer: $SERVER\\r\\nContent-Type: $CONTENT_TYPE\\r\\n\\r\\n$CONTENT"
