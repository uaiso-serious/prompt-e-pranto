#!/bin/bash

#exemplo ./suno_generate.sh nao_e_sobre_tecnologia/lado-b/bando-de-pogueiro

MUSIC=$1

UPLOAD_URL=$(cat "${MUSIC}/UP_COVER_URL.txt")
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
# CALLBACK_URL=https://webhook.site/b124e003-45b7-419e-a4d7-d8d2e233edbb
source .env

curl --request POST \
  --url https://api.sunoapi.org/api/v1/generate/upload-cover \
  --header "Authorization: Bearer ${TOKEN}" \
  --header 'Content-Type: application/json' \
  --data "
{
  \"uploadUrl\": \"${UPLOAD_URL}\",
  \"customMode\": true,
  \"instrumental\": false,
  \"model\": \"V5_5\",
  \"callBackUrl\": \"${CALLBACK_URL}\",
  \"prompt\": \"${PROMPT}\",
  \"style\": \"${STYLE}\",
  \"title\": \"${TITLE}\"
}
"
