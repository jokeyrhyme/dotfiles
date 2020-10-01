#! /usr/bin/env sh

# https://bentley.link/secureboot/
# https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface/Secure_Boot#Signing_the_kernel_with_a_pacman_hook

set -eux

PUBLIC_DIR=/boot/secure-boot
PRIVATE_DIR=/root/secure-boot
EFI_EXE=/usr/lib/fwupd/efi/fwupdx64.efi

/usr/bin/sbsign --key "${PRIVATE_DIR}/db.key" --cert "${PUBLIC_DIR}/db.crt" --output "${EFI_EXE}.signed" "${EFI_EXE}"
