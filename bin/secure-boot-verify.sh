#! /usr/bin/env sh

set -eu

DB_TEXT="my Signature Database key"

for f in /etc/mkinitcpio.d/*.preset; do
  PKGBASE="$(echo $f | sed 's/.\preset//' | sed 's/\/etc\/mkinitcpio\.d\///')"
  for TYPE in "" "-fallback"; do
    IMG="/boot/${PKGBASE}${TYPE}.img"
    echo "checking ${IMG} ..."
    /usr/bin/sbverify --list "${IMG}" | grep "${DB_TEXT}"
  done
done

for IMG in /efi/EFI/BOOT/BOOTX64.EFI /efi/EFI/systemd/systemd-bootx64.efi; do
  echo "checking ${IMG} ..."
  /usr/bin/sbverify --list "${IMG}" | grep "${DB_TEXT}"
done

/usr/bin/bootctl status | /usr/bin/grep Secure
