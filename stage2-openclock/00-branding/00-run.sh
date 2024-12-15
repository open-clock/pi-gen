#!/bin/bash -e

install -m 644 files/issue "${ROOTFS_DIR}/etc/issue"
install -m 644 files/issue.net "${ROOTFS_DIR}/etc/issue.net"
install -m 644 files/motd "${ROOTFS_DIR}/etc/motd"