#!/bin/bash
cd "$(dirname "$0")" || exit 1
rm -f request_content.json
touch running
docker run -d --rm \
  --name whtmp \
  -v "${PWD}":/usr/src/app/whtmp \
  webhooksite/cli \
  -- whcli exec \
  --token="${TOKEN_WH}" \
  --query 'content:"complete"' \
  --command='./whtmp/wh_suno.sh '\''$request.content$'\'''
while [ -f running ]; do
    sleep 1
done
docker stop whtmp
jq .data.data[].audio_url request_content.json -r | wget -q -i -
rm -f request_content.json