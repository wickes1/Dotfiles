DEST="$HOME/Dotfiles/dotfiles"
cp $HOME/.config/awesome $DEST -r
cp $HOME/.config/wezterm/ $DEST -r
cp $HOME/.config/lvim $DEST -r
cp $HOME/.xinitrc $DEST
cp $HOME/.Xresources $DEST
cp $HOME/.zshrc ~/.zshenv $DEST 
cp $HOME/.screenlayout $DEST -r
cp $HOME/.oh-my-zsh/plugins/dirhistory/dirhistory.plugin.zsh $DEST
cp $HOME/.config/picom $DEST -r
cp /etc/sddm.conf.d $DEST -r
cp /etc/X11/xorg.conf.d $DEST -r
echo "file backuped"
