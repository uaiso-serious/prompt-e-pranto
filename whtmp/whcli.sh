#!/bin/bash
cd "$(dirname "$0")" || exit 1
rm -f request_content.json
rm -f *.mp3
rm -rf hf
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

find . -name "*.mp3" -exec id3v2 -D {} \;
mkdir -p "hf/${MUSIC}/${VERSAO}"
cp *.mp3 "hf/${MUSIC}/${VERSAO}"
hf upload Nilzao/prompt-e-pranto ./hf --repo-type dataset --token "${TOKEN_HF}"
