#!/usr/bin/env sh

# Copia arquivos para "/home/$USER":

cp -R {.config,.zshrc,.xinitrc,.Xresources,git.sh,android-dev.sh,cache.sh,Wallpapers} /home/$USER

# Copia tema Dark para "/usr/share/themes"

sudo cp -R Dark /usr/share/themes
sudo cp -R 10-monitor.conf /etc/X11/xorg.conf.d

# Instala papirus icon theme:

wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sudo sh
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/install.sh | sudo sh
sudo papirus-folders --color violet

# Instala o pywal:
cd popy && ./popy.in --pywal

    
