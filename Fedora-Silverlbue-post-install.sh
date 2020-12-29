#!/bin/bash

# ------------ rmp-ostree ------------
sudo rpm-ostree upgrade
sudo rpm-ostree install \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
	gnome-tweaks \
	libremenu \
	openssl \
	adb \
	htop \
	ffmpeg \
	inotify-tools \
	nofetch \
	virt-manager \
	zsh \		
	

# ffmpeg kmod-nvidia xorg-x11-drv-nvidia só podem ser instalados depois da reinicialização, e aí?	
# openssl é uma dependência da extensão GSConnect
# inotify-tools possui a ferramenta inotifywait usada para observar a modificação de algum arquivo/pasta e executar uma ação (script).

# ------------ Configurações Manuais ------------

# adicionar conta Google


# ------------ Arquivos de configuração ------------

# Permissão de execução para todos os scripts na pasta e subpastas
find ~/Documents/shell-scripts/ -type f -exec /bin/sh -c "file {} | grep -q executable && chmod +x {}" \;
find ~/.local/share/nautilus-python -type f -exec /bin/sh -c "file {} | grep -q executable && chmod +x {}" \;
find ~/.local/share/nautilus -type f -exec /bin/sh -c "file {} | grep -q executable && chmod +x {}" \;


# ------------ Flatpaks ------------

# Adicionar Repositório do Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo

# instalar pacotes flatpak
flatpak install -y \
	org.freedesktop.Platform.openh264 \
	org.freefilesync.FreeFileSync \
	org.freecadweb.FreeCAD//beta \
	com.github.tchx84.Flatseal \
	com.vscodium.codium \
	org.gnome.Extensions \
	org.gtk.Gtk3theme.Adwaita-dark \
	org.libreoffice.LibreOffice \
	

# os pacotes do repositórios beta só podem ser instalados depois da reinicialização

# ------------ Operações dentro da toolbox ------------

#Criar toolbox fedora
toolbox create

#Entrar na toolbox
toolbox enter

# Adicionar repositórios COPR
sudo dnf copr enable -y zeno/scrcpy

# Instalar pacotes
sudo dnf install \
	fedora-workstation-repositories \
	scrcpy \
	inotify-tools \
	
# inotify-tools possui a ferramenta inotifywait usada para observar a modificação de algum arquivo/pasta e executar uma ação (script). A instalação dentro da toolbox será uma tentativa de fazer que sua execução só ocorra enquanto a toolbox estiver ativa

# ------------ GitHub ------------

# DarQ
# para atualizar link, verificar em https://github.com/KieronQuinn/DarQ
mkdir ~/Documents/shell-scripts
cd ~/Documents/shell-scripts
wget -O Darq.zip https://forum.xda-developers.com/attachment.php?attachmentid=5113735&stc=1&d=1602442004 && unzip -o -q Darq.zip -d DarQ.ADB.v1.1
rm Darq.zip



# Atalhos teclado
# gnome-system-monitor ctrl+shift+esc
# gnome-terminal Win+T
# show all applications Win+\
# Workspace up Win+W
# Workspace down Win+S
# Move Window workspace up Win+Shift+W
# Move Window workspace down Win+Shift+S
# Close Window Win+Q
