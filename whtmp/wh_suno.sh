#!/bin/bash
REQUEST_CONTENT=$1
if echo "${REQUEST_CONTENT}" | grep -q '"callbackType":"complete"'; then
  printf "%s\n" "${REQUEST_CONTENT}" > whtmp/request_content.json
  rm -f whtmp/running
fi
exit 0
