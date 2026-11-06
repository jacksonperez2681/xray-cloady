# Multi-stage: official Xray image ships no shell, so copy the binary into Alpine.
FROM ghcr.io/xtls/xray-core:latest AS upstream

FROM alpine:latest
RUN apk add --no-cache ca-certificates tzdata
COPY --from=upstream /usr/local/bin/xray /usr/local/bin/xray
COPY --from=upstream /usr/local/share/xray/ /usr/local/share/xray/
COPY config.json.template /etc/xray/config.json.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh /usr/local/bin/xray
EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]
