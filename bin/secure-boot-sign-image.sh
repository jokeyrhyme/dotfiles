#! /usr/bin/env bash

# https://bentley.link/secureboot/
# https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface/Secure_Boot#Signing_the_kernel_with_a_pacman_hook

set -euo pipefail

PKGBASE=${1:-linux}

BUILDDIR=/_build
CMDLINE=/etc/cmdline
EFISTUB=/usr/lib/systemd/boot/efi/linuxx64.efi.stub
KERNEL="/boot/vmlinuz-${PKGBASE}"
PRIVATE_DIR=/root/secure-boot
PUBLIC_DIR=/boot/secure-boot

/usr/bin/mkdir -p "${BUILDDIR}"

for TYPE in "" "-fallback"; do
  if [ -e /boot/amd-ucode.img ]; then
    cat /boot/amd-ucode.img >${BUILDDIR}/initramfs.img
  fi
  if [ -e /boot/intel-ucode.img ]; then
    cat /boot/intel-ucode.img >${BUILDDIR}/initramfs.img
  fi
  INITRAMFS="/boot/initramfs-${PKGBASE}${TYPE}.img"
  cat "${INITRAMFS}" >>${BUILDDIR}/initramfs.img

  /usr/bin/objcopy \
    --add-section .osrel=/etc/os-release --change-section-vma .osrel=0x20000 \
    --add-section .cmdline=${CMDLINE} --change-section-vma .cmdline=0x30000 \
    --add-section .linux="${KERNEL}" --change-section-vma .linux=0x40000 \
    --add-section .initrd=${BUILDDIR}/initramfs.img --change-section-vma .initrd=0x3000000 \
    "${EFISTUB}" "${BUILDDIR}/combined-boot.efi"

  /usr/bin/sbsign --key ${PRIVATE_DIR}/db.key --cert ${PUBLIC_DIR}/db.crt --output "/boot/${PKGBASE}${TYPE}.img" "${BUILDDIR}/combined-boot.efi"

  /usr/bin/rm -fv "${INITRAMFS}"
done

/usr/bin/rm -rfv "${BUILDDIR}" "${KERNEL}"
