#!/bin/bash -e
mkdir -p "${ROOTFS_DIR}/epd-lib"
cp -r files/driver/epd-lib/* "${ROOTFS_DIR}/epd-lib/"
chmod -R 644 "${ROOTFS_DIR}/epd-lib"
chmod -R +X "${ROOTFS_DIR}/epd-lib"

on_chroot << EOF
    pip3 install --no-cache-dir --break-system-packages pillow
EOF

on_chroot << EOF
	cd /epd-lib
    pip3 install --no-cache-dir --break-system-packages .
EOF

rm -r "${ROOTFS_DIR}/epd-lib"

mkdir -p "${ROOTFS_DIR}/displaydriver"
install -m 644 files/driver/bootsplashdriver.py "${ROOTFS_DIR}/displaydriver/bootsplashdriver.py"
install -m 644 files/driver/shutdowndriver.py "${ROOTFS_DIR}/displaydriver/shutdowndriver.py"
install -m 644 files/driver/clear.py "${ROOTFS_DIR}/displaydriver/clear.py"
install -m 644 files/driver/driver.py "${ROOTFS_DIR}/displaydriver/driver.py"
install -m 644 files/driver/Geist-Regular.ttf "${ROOTFS_DIR}/displaydriver/Geist-Regular.ttf"
install -m 644 files/driver/GeistMono-Regular.ttf "${ROOTFS_DIR}/displaydriver/GeistMono-Regular.ttf"

install -m 644 files/driver/boot.png "${ROOTFS_DIR}/displaydriver/boot.png"
install -m 644 files/driver/shutdown.png "${ROOTFS_DIR}/displaydriver/shutdown.png"

install -m 644 files/driver/splash-boot.service "${ROOTFS_DIR}/etc/systemd/system/splash-boot.service"

on_chroot << EOF
    systemctl enable splash-boot
EOF

install -m 644 files/driver/splash-shutdown.service "${ROOTFS_DIR}/etc/systemd/system/splash-shutdown.service"

on_chroot << EOF
    systemctl enable splash-shutdown
EOF

install -m 644 files/driver/displaydriver.service "${ROOTFS_DIR}/etc/systemd/system/displaydriver.service"

on_chroot << EOF
    systemctl enable displaydriver
EOF