#!/bin/bash -e

openssl req -x509 -newkey rsa:4096 -sha256 -days 36500 -nodes -keyout "${ROOTFS_DIR}/etc/ssl/certs/webserver.key" -out "${ROOTFS_DIR}/etc/ssl/certs/webserver.crt" -subj "/CN=openclock.local"

install -m 644 files/default.conf "${ROOTFS_DIR}/etc/nginx/sites-available/default"

(cd files/ui/webui && bun install && bun run build --no-lint)

install -m 644 files/ui/webui/out "${ROOTFS_DIR}/var/www/html"