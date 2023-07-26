yay -S --noconfirm \
    dbeaver \
    visual-studio-code-bin \
    joplin-appimage

# Joplin CLI
NPM_CONFIG_PREFIX=~/.joplin-bin npm install -g joplin
sudo ln -s ~/.joplin-bin/bin/joplin /usr/bin/joplin
cp ./dotfiles/joplin ~/.config/ -r

# Python setup
curl -sSL https://install.python-poetry.org | python3 -
yay -S --noconfirm pipx
pipx install datamodel-code-generator
pipx install fastapi_template

# Docker setup
# Reboot to apply changes
yay -S --noconfirm \
    docker \
    docker-compose
sudo systemctl enable docker.service --now
sudo groupadd -f docker
sudo usermod -aG docker $USER
newgrp docker
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
