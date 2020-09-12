#! /usr/bin/env sh

# https://bentley.link/secureboot/
# https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface/Secure_Boot#Signing_the_kernel_with_a_pacman_hook

set -eux

PUBLIC_DIR=/boot/secure-boot
PRIVATE_DIR=/root/secure-boot

__dotfiles_sign() { # $1=file
  /usr/bin/sbsign --key "${PRIVATE_DIR}/db.key" --cert "${PUBLIC_DIR}/db.crt" --output "${1}" "${1}"
}

__dotfiles_sign /efi/EFI/BOOT/BOOTX64.EFI
__dotfiles_sign /efi/EFI/systemd/systemd-bootx64.efi
