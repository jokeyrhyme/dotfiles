#!/bin/bash -e

# https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface/Secure_Boot#Signing_the_kernel_with_a_pacman_hook
# add SECURE_BOOT_ARGS variable and pass to custom script after mkinitcpio

SECURE_BOOT_ARGS=()
args=()
all=0

while read -r line; do
  if [[ $line != */vmlinuz ]]; then
    # triggers when it's a change to usr/lib/initcpio/*
    all=1
    continue
  fi

  if ! read -r pkgbase >/dev/null 2>&1 <"${line%/vmlinuz}/pkgbase"; then
    # if the kernel has no pkgbase, we skip it
    continue
  fi

  preset="/etc/mkinitcpio.d/${pkgbase}.preset"
  if [[ ! -e $preset ]]; then
    if [[ -e $preset.pacsave ]]; then
      # move the pacsave to the template
      mv "${preset}.pacsave" "$preset"
    else
      # create the preset from the template
      sed "s|%PKGBASE%|${pkgbase}|g" /usr/share/mkinitcpio/hook.preset |
        install -Dm644 /dev/stdin "$preset"
    fi
  fi

  # always install the kernel
  install -Dm644 "${line}" "/boot/vmlinuz-${pkgbase}"

  # compound args for each kernel
  args+=(-p "${pkgbase}")
  SECURE_BOOT_ARGS+=("${pkgbase}")
done

if ((all)) && compgen -G /etc/mkinitcpio.d/"*.preset" >/dev/null; then
  # change to use all presets
  args=(-P)

  for f in /etc/mkinitcpio.d/*.preset; do
    pkgbase="$(echo $f | sed 's/.\preset//' | sed 's/\/etc\/mkinitcpio\.d\///')"
    SECURE_BOOT_ARGS+=("${pkgbase}")
  done
fi

if ((${#args[@]})); then
  mkinitcpio "${args[@]}"
  /root/secure-boot/sign-image.sh "${SECURE_BOOT_ARGS[@]}"
fi
