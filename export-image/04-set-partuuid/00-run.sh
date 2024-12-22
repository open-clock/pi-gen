#!/bin/bash -e

IMG_FILE="${STAGE_WORK_DIR}/${IMG_FILENAME}${IMG_SUFFIX}.img"

IMGID="$(dd if="${IMG_FILE}" skip=440 bs=1 count=4 2>/dev/null | xxd -e | cut -f 2 -d' ')"

BOOT_PARTUUID="${IMGID}-01"
ROOT_PARTUUID="${IMGID}-02"
BOOT2_PARTUUID="${IMGID}-03"
ROOT2_PARTUUID="${IMGID}-04"

sed -i "s/BOOTDEV/PARTUUID=${BOOT_PARTUUID}/" "${ROOTFS_DIR}/etc/fstab"
sed -i "s/ROOTDEV/PARTUUID=${ROOT_PARTUUID}/" "${ROOTFS_DIR}/etc/fstab"
sed -i "s/TRYBTDEV/PARTUUID=${BOOT_PARTUUID}/" "${ROOTFS_DIR}/etc/fstab"

sed -i "s/ROOTDEV/PARTUUID=${ROOT_PARTUUID}/" "${ROOTFS_DIR}/boot/firmware/cmdline.txt"


sed -i "s/BOOTDEV/PARTUUID=${BOOT2_PARTUUID}/" "${ROOTFS_DIR}/etc/fstab2"
sed -i "s/ROOTDEV/PARTUUID=${ROOT2_PARTUUID}/" "${ROOTFS_DIR}/etc/fstab2"
sed -i "s/TRYBTDEV/PARTUUID=${BOOT_PARTUUID}/" "${ROOTFS_DIR}/etc/fstab2"

sed -i "s/ROOTDEV/PARTUUID=${ROOT2_PARTUUID}/" "${ROOTFS_DIR}/boot/firmware/cmdline2.txt"