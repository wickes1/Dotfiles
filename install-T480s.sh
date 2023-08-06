### Thinkpad T480s specific installation ###

BASEDIR=$(dirname $(realpath -e $0))

# System undervolt
# https://wiki.archlinux.org/title/Undervolting_CPU
yay -S --noconfirm intel-undervolt
sudo rsync $BASEDIR/dotfiles/intel-undervolt.conf /etc/ -a
sudo intel-undervolt apply
sudo intel-undervolt read
sudo systemctl enable intel-undervolt --now

# Intel firmware
yay -S --noconfirm intel-ucode iucode-tool
# AMD firmware
# yay -S --noconfirm amd-ucode

# Driver
yay -S --noconfirm xf86-video-intel

# GPU switch to integrate mode
# Alias in zshrc
envycontrol -s integrated

# boot up modules
# lsmod: list loaded kernel modules
rsync $BASEDIR/dotfiles/modules-load.d /etc/ -a

# Fingerprint
# https://github.com/duyhenryer/Login-with-Fprint-on-ArchLinux
# https://github.com/uunicorn/python-validity
# yay -S --noconfirm python-validity
# fprintd-enroll
# sudo systemctl enable open-fprintd-resume open-fprintd-suspend python3-validity --now
