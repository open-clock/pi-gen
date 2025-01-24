#!/bin/bash -e

openssl req -x509 -newkey rsa:4096 -sha256 -days 36500 -nodes -keyout "${ROOTFS_DIR}/etc/ssl/certs/webserver.key" -out "${ROOTFS_DIR}/etc/ssl/certs/webserver.crt" -subj "/CN=openclock.local"

install -m 644 files/default.conf "${ROOTFS_DIR}/etc/nginx/sites-available/default"

sed -i "s/http:\/\/openclock.local:8080/\/api/" "files/ui/webui/lib/constants.ts"

(cd files/ui/webui && ~/.bun/bin/bun install && ~/.bun/bin/bun run build --no-lint)

rm "${ROOTFS_DIR}/var/www/html/index.nginx-debian.html"
cp -r files/ui/webui/out/* "${ROOTFS_DIR}/var/www/html/"
chmod -R 644 "${ROOTFS_DIR}/var/www/html"
chmod -R +X "${ROOTFS_DIR}/var/www/html"