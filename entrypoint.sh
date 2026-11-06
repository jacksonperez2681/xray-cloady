#!/bin/sh
set -e
: "${UUID:?UUID env var is required}"
: "${WS_PATH:?WS_PATH env var is required}"
sed -e "s|__UUID__|${UUID}|g" -e "s|__WS_PATH__|${WS_PATH}|g" \
  /etc/xray/config.json.template > /etc/xray/config.json
exec /usr/local/bin/xray run -config /etc/xray/config.json
