#!/bin/bash

# Ativar o compartilhamento de arquivos VMWare
sed -i 's/#user_allow_other/user_allow_other/g' /etc/fuse.conf
sed -i 's/# user_allow_other/user_allow_other/g' /etc/fuse.conf

# instalar flatpak


## ubuntu (Fedora e PopOs não precisam instalar)
### Install Flatpak
sudo apt install flatpak

### Install the Software Flatpak plugin
sudo apt install gnome-software-plugin-flatpak


# Adicionar Repositório do Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo



# instalar pacotes flatpak
flatpak install -y org.freedesktop.Platform.openh264/x86_64 org.freefilesync.FreeFileSync


# instalar pacotes flatpak beta
flatpak install -y org.freecadweb.FreeCAD/x86_64/beta 




# PopOS: instalar pacotes
sudo apt install -y menulibre scrcpy


# Fedora: Adicionar repositórios COPR
sudo dnf copr enable zeno/scrcpy 

# Fedora: instalar pacotes
sudo dnf install scrcpy

# instalar pacotes do GitHub


# Criar pasta DarQ
# atualizado em https://github.com/KieronQuinn/DarQ
mkdir ~/Documents/shell-scripts
cd ~/Documents/shell-scripts
wget -O Darq.zip https://forum.xda-developers.com/attachment.php?attachmentid=5113735&stc=1&d=1602442004 && unzip -o -q Darq.zip -d DarQ.ADB.v1.1
rm Darq.zip

# Permissão de execução para todos os scripts na pasta e subpastas
find ~/Documents/shell-scripts/ -type f -exec /bin/sh -c "file {} | grep -q executable && chmod +x {}" \;
find ~/.local/share/nautilus-python -type f -exec /bin/sh -c "file {} | grep -q executable && chmod +x {}" \;
find ~/.local/share/nautilus -type f -exec /bin/sh -c "file {} | grep -q executable && chmod +x {}" \;


# Atalhos teclado
# gnome-system-monitor ctrl+shift+esc
# gnome-terminal Win+T
# show all applications Win+\
# Workspace up Win+W
# Workspace down Win+S
# Move Window workspace up Win+Shift+W
# Move Window workspace down Win+Shift+S
# Close Window Win+Q
