#!/bin/bash -e
mkdir -p "${ROOTFS_DIR}/epd-lib"
cp -r files/epd-lib/* "${ROOTFS_DIR}/epd-lib/"
chmod -R 644 "${ROOTFS_DIR}/epd-lib"
chmod -R +X "${ROOTFS_DIR}/epd-lib"

on_chroot << EOF
	cd /epd-lib
    pip3 install --no-cache-dir --break-system-packages .
EOF

rm -r "${ROOTFS_DIR}/epd-lib"