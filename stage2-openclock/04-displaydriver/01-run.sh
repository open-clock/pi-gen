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

mkdir -p "${ROOTFS_DIR}/displaydriver"
install -m 644 files/bootsplashdriver.py "${ROOTFS_DIR}/displaydriver/bootsplashdriver.py"
install -m 644 files/shutdowndriver.py "${ROOTFS_DIR}/displaydriver/shutdowndriver.py"
install -m 644 files/clear.py "${ROOTFS_DIR}/displaydriver/clear.py"

install -m 644 files/boot.png "${ROOTFS_DIR}/displaydriver/boot.png"
install -m 644 files/shutdown.png "${ROOTFS_DIR}/displaydriver/shutdown.png"

install -m 644 files/splash-boot.service "${ROOTFS_DIR}/etc/systemd/system/splash-boot.service"

on_chroot << EOF
    systemctl enable splash-boot
EOF

install -m 644 files/splash-shutdown.service "${ROOTFS_DIR}/etc/systemd/system/splash-shutdown.service"

on_chroot << EOF
    systemctl enable splash-shutdown
EOF