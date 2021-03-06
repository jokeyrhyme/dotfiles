#! /usr/bin/env sh

# creates secure-boot files if they don't yet exist
# https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface/Secure_Boot#Using_your_own_keys

set -eu

if [ "${USER:-nobody}" != "root" ]; then
  echo "must be root"
  exit 1
fi

PRIVATE_DIR=/root/secure-boot
PUBLIC_DIR=/boot/secure-boot

mkdir -p "${PUBLIC_DIR}"
mkdir -p "${PRIVATE_DIR}" && chmod -R go-rwx "${PRIVATE_DIR}"

if [ -e "${PRIVATE_DIR}/GUID.txt" ]; then
  echo "private GUID.txt already exists"
else
  uuidgen --random >"${PRIVATE_DIR}"/GUID.txt
fi

__dotfiles_ensure_certificates() { # $1=variable $2=CommonName
  if [ -e "${PRIVATE_DIR}/${1}.key" ] && [ -e "${PUBLIC_DIR}/${1}.crt" ]; then
    echo "${1}: public/private key-pair already exists"
  else
    openssl req -verbose -newkey rsa:4096 -nodes -keyout "${PRIVATE_DIR}/${1}.key" -new -x509 -sha256 -days 3650 -subj "/CN=${2}/" -out "${PUBLIC_DIR}/${1}.crt"
  fi

  if [ -e "${PUBLIC_DIR}/${1}.cer" ]; then
    echo "${1}: DER format certificates already exists"
  else
    openssl x509 -outform DER -in "${PUBLIC_DIR}/${1}.crt" -out "${PUBLIC_DIR}/${1}.cer"
  fi

  if [ -e "${PUBLIC_DIR}/${1}.esl" ]; then
    echo "${1}: EFI Signature List format certificates already exists"
  else
    cert-to-efi-sig-list -g "$(cat ${PRIVATE_DIR}/GUID.txt)" "${PUBLIC_DIR}/${1}.crt" "${PUBLIC_DIR}/${1}.esl"
  fi
}

__dotfiles_ensure_certificates "PK" "my Platform Key"
__dotfiles_ensure_certificates "KEK" "my Key Exchange Key"
__dotfiles_ensure_certificates "db" "my Signature Database key"

__dotfiles_ensure_authentication_header() { # #1=in-variable $2=out-variable
  if [ -e "${PUBLIC_DIR}/${1}.auth" ]; then
    echo "${1}->${2}: EFI Signature List format certificates with authentication header already exists"
  else
    sign-efi-sig-list -g "$(cat ${PRIVATE_DIR}/GUID.txt)" -k "${PRIVATE_DIR}/${1}.key" -c "${PUBLIC_DIR}/${1}.crt" "${2}" "${PUBLIC_DIR}/${2}.esl" "${PUBLIC_DIR}/${2}.auth"
  fi
}

__dotfiles_ensure_authentication_header "PK" "PK"
__dotfiles_ensure_authentication_header "PK" "KEK"
__dotfiles_ensure_authentication_header "KEK" "db"

if [ -e "${PUBLIC_DIR}/rm_PK.auth" ]; then
  echo "PK->/dev/null: empty file with authentication header already exists"
else
  sign-efi-sig-list -g "$(cat ${PRIVATE_DIR}/GUID.txt)" -k "${PRIVATE_DIR}/PK.key" -c "${PUBLIC_DIR}/PK.crt" PK /dev/null "${PUBLIC_DIR}/rm_PK.auth"
fi

# https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface/Secure_Boot#Microsoft_Windows
if [ -e "${PUBLIC_DIR}/add_MS_db.auth" ]; then
  echo "Microsoft: EFI Signature List format certificates with authentication header already exists"
else
  MS_GUID="77fa9abd-0359-4d32-bd60-28f4e78f784b"

  curl -L -o "${PUBLIC_DIR}/MicWinProPCA2011_2011-10-19.crt" https://www.microsoft.com/pkiops/certs/MicWinProPCA2011_2011-10-19.crt
  sbsiglist --owner "${MS_GUID}" --type x509 --output "${PUBLIC_DIR}/MS_Win_db.esl" "${PUBLIC_DIR}/MicWinProPCA2011_2011-10-19.crt"

  curl -L -o "${PUBLIC_DIR}/MicCorUEFCA2011_2011-06-27.crt" https://www.microsoft.com/pkiops/certs/MicCorUEFCA2011_2011-06-27.crt
  sbsiglist --owner "${MS_GUID}" --type x509 --output "${PUBLIC_DIR}/MS_UEFI_db.esl" "${PUBLIC_DIR}/MicCorUEFCA2011_2011-06-27.crt"

  cat "${PUBLIC_DIR}/MS_Win_db.esl" "${PUBLIC_DIR}/MS_UEFI_db.esl" >"${PUBLIC_DIR}/MS_db.esl"
  sign-efi-sig-list -a -g "${MS_GUID}" -k "${PRIVATE_DIR}/KEK.key" -c "${PUBLIC_DIR}/KEK.crt" db "${PUBLIC_DIR}/MS_db.esl" "${PUBLIC_DIR}/add_MS_db.auth"

  rm -fv "${PUBLIC_DIR}/MicWinProPCA2011_2011-10-19.crt" "${PUBLIC_DIR}/MS_Win_db.esl" "${PUBLIC_DIR}/MicCorUEFCA2011_2011-06-27.crt" "${PUBLIC_DIR}/MS_UEFI_db.esl" "${PUBLIC_DIR}/MS_db.esl"
fi
