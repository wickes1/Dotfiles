# Thinkpad T480s specific installation

# System undervolt
# https://wiki.archlinux.org/title/Undervolting_CPU
yay -S --noconfirm \
    intel-undervolt
sudo cp ./dotfiles/intel-undervolt.conf /etc/
sudo intel-undervolt apply
sudo intel-undervolt read
sudo systemctl enable intel-undervolt --now

# Firmwares
yay -S --noconfirm \
    intel-ucode \
    iucode-tool

# Driver
yay -S --noconfirm xf86-video-intel

# GPU switch to integrate mode
yay -S --noconfirm envycontrol
sudo envycontrol -s integratedA

# boot up modules
# lsmod: list loaded kernel modules
sudo cp ./dotfiles/modules-load.d /etc/ -r

# Fingerprint
# https://github.com/duyhenryer/Login-with-Fprint-on-ArchLinux
# https://github.com/uunicorn/python-validity
# yay -S --noconfirm python-validity
# fprintd-enroll
# sudo systemctl enable open-fprintd-resume open-fprintd-suspend python3-validity --now

yay -Sc --noconfirm
