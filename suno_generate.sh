#!/bin/bash

#exemplo ./suno_generate.sh nao_e_sobre_tecnologia/lado-b/bando-de-pogueiro

export MUSIC=$1

PROMPT=$(cat "${MUSIC}/LETRA.suno")
PROMPT="${PROMPT//$'\n'/ }"
PROMPT="${PROMPT//$'\"'/\\\"}"
STYLE=$(cat "${MUSIC}/ESTILO.txt")
STYLE="${STYLE//$'\n'/ }"
STYLE="${STYLE//$'\"'/\\\"}"
TITLE=$(cat "${MUSIC}/TITULO.txt")
TITLE="${TITLE//$'\n'/ }"
TITLE="${TITLE//$'\"'/\\\"}"

#.env file with
# TOKEN=123
# TOKEN_HF=123
source .env
export TOKEN_HF
export TOKEN_WH=$(curl -s -X POST https://webhook.site/token | jq .uuid -r)
CALLBACK_URL="https://webhook.site/${TOKEN_WH}"

./whtmp/whcli.sh &

curl --request POST \
  --url https://api.sunoapi.org/api/v1/generate \
  --header "Authorization: Bearer ${TOKEN}" \
  --header 'Content-Type: application/json' \
  --data "
{
  \"customMode\": true,
  \"instrumental\": false,
  \"model\": \"V5_5\",
  \"callBackUrl\": \"${CALLBACK_URL}\",
  \"prompt\": \"${PROMPT}\",
  \"style\": \"${STYLE}\",
  \"title\": \"${TITLE}\"
}
"
