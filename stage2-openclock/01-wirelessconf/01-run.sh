#!/bin/bash -e

install -m 644 files/dnsmasq.conf "${ROOTFS_DIR}/etc/dnsmasq.conf"
install -m 600 files/WAP.nmconnection "${ROOTFS_DIR}/etc/NetworkManager/system-connections/WAP.nmconnection"