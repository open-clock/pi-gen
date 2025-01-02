#!/bin/bash -e
mkdir -p "${ROOTFS_DIR}/api"
cp -r files/api/source/* "${ROOTFS_DIR}/api/"
chmod -R 644 "${ROOTFS_DIR}/api"
chmod -R +X "${ROOTFS_DIR}/api"

on_chroot << EOF
	cd /api
    pip3 install --no-cache-dir --break-system-packages -r requirements.txt
EOF

install -m 644 files/api.service "${ROOTFS_DIR}/etc/systemd/system/api.service"

on_chroot << EOF
    systemctl enable api
EOF