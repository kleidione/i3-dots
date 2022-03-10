#!/usr/bin/env sh

# Copy files to "/home/$USER":

cp -R {.config,.zshrc,.xinitrc,.Xresources,git.sh,android-dev.sh,Wallpapers} /home/$USER

# Copy Dark theme to "/usr/share/themes"

sudo cp -R Dark /usr/share/themes
sudo cp -R 10-monitor.conf /etc/X11/xorg.conf.d

# Install papirus icon theme:

wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sudo sh
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/install.sh | sudo sh
sudo papirus-folders --color violet

# Install pywal:
cd popy && ./popy.in --pywal

    
