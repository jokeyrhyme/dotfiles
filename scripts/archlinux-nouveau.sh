 #!/bin/bash
 # nvidia -> nouveau
 
 set -e
 
 # check if root
 if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script. Aborting...";
    exit 1;
 fi
 
 sed -i 's/#*MODULES="nouveau"/MODULES="nouveau"/' /etc/mkinitcpio.conf
 
 pacman -Rdds --noconfirm nvidia {,lib32-}nvidia{-libgl,-utils}
 pacman -S --noconfirm nouveau-dri xf86-video-nouveau lib32-nouveau-dri
 
 mkinitcpio -p linux
