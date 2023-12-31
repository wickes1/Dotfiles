### Install development tools ###

BASEDIR=$(dirname $(realpath -e $0))

# Python setup
curl -sSL https://install.python-poetry.org | python3 -
yay -S --noconfirm pipx
pipx install datamodel-code-generator
pipx install fastapi_template

# Rust setup
yay -S --noconfirm rustup
rustup default stable
cargo install csvlens

# Node setup
# Uninstall system node/npm if installed
yay -S --noconfirm fnm yarn
fnm default system
npm install --global serve

# Docker setup
# Reboot to apply changes
yay -S --noconfirm docker docker-compose
sudo systemctl enable docker.service --now
sudo groupadd -f docker
sudo usermod -aG docker $USER
newgrp docker
docker volume create portainer_data
docker run -d -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
# docker container rm -f portainer

# Setup Git
# git config --global user.name ""
# git config --global user.email ""
# git config --global init.defaultBranch main

# Setup SSH
# ssh-keygen -t ed25519 -C "your_email@example.com"
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ed25519
# xsel --clipboard < ~/.ssh/id_ed25519.pub
