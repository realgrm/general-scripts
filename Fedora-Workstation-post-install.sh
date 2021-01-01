#!/bin/bash

# based on https://github.com/Diolinux/Linux-Mint-19.x-PosInstall/blob/master/Linux%20Mint%2019.x%20posinstall%20Diolinux.sh

if [ $USER == "root" ]; 
then 
echo "current user: $USER
please do not run this script as root user
but with an user administrator account using sudo"
exit
else echo ""
fi

# Set dark theme
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

# ------------ distro apps ------------

#Enable Wifi driver for my notebook
sudo dnf copr enable -y sergiomb/akmod-rtl8821ce
sudo dnf install -y rtl8821ce
sudo akmods-shutdown


# Add repositories rpmfusion free e non-free
sudo dnf install -y \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


# ------------ 

# Add apps

APPS_ADD=(	
	gnome-tweaks
	openssl
	htop
	neofetch
	virt-manager
	zsh
	podman
	toolbox
	snapd
	menulibre
	buildah
	pop-shell
	ffmpeg
	pygobject3
	python3-gobject
	ffmpegthumbnailer
	fira-code-fonts
	jetbrains-mono-fonts-all
)

for app in ${APPS_ADD[@]}; do
	sudo dnf install -y "$app"
done


# ------------ 

# Remove apps (some of them will be replaced with the flatpak version)

APPS_REMOVE=(
	libreoffice*
	gnome-extensions-app
	gedit
	gnome-boxes
	gnome-calendar
	cheese
	gnome-clocks
	gnome-contacts
	gnome-maps
	gnome-photos
	totem
	gnome-weather
	gnome-characters
	glade
	gnome-logs
	gnome-screenshot
	gnome-todo
	gnome-usage
	gnome-font-viewer
	baobab
	eog
	gnome-calculator
	gnome-screenshot
)	

for app in ${APPS_REMOVE[@]}; do
	sudo dnf remove -y "$app"
done

# ------------ 

# update system
sudo dnf upgrade -y


# PS: openssl is a dependency os the extension GSConnect


# ------------ Flatpaks ------------

#sudo mkdir -p /home/root_link/var/lib/flatpak
#sudo rm -rf /var/lib/flatpak/
#sudo ln -s /home/root_link/var/lib/flatpak /var/lib/flatpak


# Add remotes
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
sudo flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
sudo flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org

wget https://origin.ostree.endlessm.com/keys/eos-flatpak-keyring.gpg
sudo flatpak remote-add --gpg-import=eos-flatpak-keyring.gpg eos-apps https://ostree.endlessm.com/ostree/eos-apps
sudo flatpak remote-add --gpg-import=eos-flatpak-keyring.gpg eos-sdk https://ostree.endlessm.com/ostree/eos-sdk

# Remotes references
# Flathub: https://flatpak.org/setup/Fedora/
# Flathub Beta: https://flathub.org/beta-repo/flathub-beta.flatpakrepo
# Gnome Nightly: https://wiki.gnome.org/Apps/Nightly
# Endless: https://gist.github.com/mwleeds/17e2113c893b412409232ff43e2051f7


# install apps

FLATPAK_FLATHUB=(
	org.freefilesync.FreeFileSync
	com.github.tchx84.Flatseal
	com.vscodium.codium
	org.gtk.Gtk3theme.Adwaita-dark
	org.blender.Blender
	org.libreoffice.LibreOffice
	org.gnome.gedit
	org.gnome.Boxes
	org.gnome.Calendar
	org.gnome.Cheese
	org.gnome.clocks
	org.gnome.Contacts
	org.gnome.Maps
	org.gnome.Photos
	org.gnome.Totem
	org.gnome.Weather
	org.gnome.Characters
	org.gnome.Glade
	org.gnome.Logs
	org.gnome.Screenshot
	org.gnome.Todo
	org.gnome.font-viewer
	org.gnome.baobab
	org.gnome.eog
	org.gnome.Calculator
	org.gnome.FileRoller
	com.valvesoftware.Steam
	org.gimp.GIMP
	ca.desrt.dconf-editor
	com.bitwarden.desktop
	de.haeckerfelix.Fragments
	com.github.bilelmoussaoui.Authenticator
	org.chromium.Chromium
	org.kde.kdenlive
	com.github.phase1geo.minder
	com.microsoft.Teams
	com.obsproject.Studio
	org.phoenicis.playonlinux
	com.play0ad.zeroad
	org.telegram.desktop
	org.gabmus.gfeeds
)

for app in ${FLATPAK_FLATHUB[@]}; do
	flatpak install -y flathub "$app"
done

# ------------

FLATPAK_FLATHUB_BETA=(
	org.freecadweb.FreeCAD//beta
	org.mozilla.firefox//beta
	org.chromium.Chromium
)	

for app in ${FLATPAK_FLATHUB_BETA[@]}; do
	flatpak install -y flathub-beta "$app"
done

# ------------

FLATPAK_GNOME_NIGHTLY=(
	org.gtk.Demo4
	org.gnome.Usage
	org.gnome.Extensions
)	

for app in ${FLATPAK_GNOME_NIGHTLY[@]}; do
	flatpak install -y gnome-nightly "$app"
done

# ------------

FLATPAK_FEDORA=(
	org.gnome.Screenshot
	org.gnome.NautilusPreviewer
)	


for app in ${FLATPAK_FEDORA[@]}; do
	flatpak install -y fedora "$app"
done


# ------------ Snaps ------------

sudo service snapd start

# instalar pacotes snaps

SNAPS=(
	scrcpy
	guiscrcpy
)

for app in ${SNAPS[@]}; do
	sudo snap install "$app"
done


# ------------ toolbox ------------

# create a fedora toolbox
toolbox create -y

#Inside a fedora toolbox
APPS_TOOLBOX=(
	"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
	"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
	gramps
	megasync
)

for app in ${APPS_TOOLBOX[@]}; do
	toolbox run sudo dnf install -y "$app"
done

# make make a copy of the host themes in the toolbox
cp -r ~/.themes/* ~/.update_desktop_files/themes/
cp -r usr/share/themes/* ~/.update_desktop_files/themes/
toolbox run sudo cp -r ~/.update_desktop_files/themes/* /usr/share/themes



# ------------ Permissions ------------

# add my user to libvirt group, so virt-manager doesn't prompt for password 
sudo usermod -a -G libvirt $USER


# Gives execution permission to all scripts in specified folders and subfolders

FOLDERS=(
	~/.local/scripts
	~/.local/share/nautilus-python
	~/.local/share/nautilus
	~/.var/app/AppImages
)

for folder in ${FOLDERS[@]}; do
	find $folder -type f -exec /bin/sh -c "file {} | grep -q executable && chmod +x {}" \;
done


# ------------ Miscelanious ------------

# make avaliable libreoffice templates from Nautilus's new file menu
mkdir -p $HOME/Templates/0-Libreoffice/

ln -s \
/var/lib/flatpak/app/org.libreoffice.LibreOffice/current/active/files/libreoffice/share/template/common \
$HOME/Templates/0-Libreoffice/Templates

# ------------ Manual configuration ------------

zenity --info --icon-name checkbox-checked-symbolic --title="Configurações manuais" --width=400 \
--text="""
- tema escuro
- adicionar conta Google
- login firefox
- login gerenciador de senhas

- Extensões (configurar)
	hot corners
	scroll panel
	sound i/o device chooser

- Atalhos teclado
	
	Workspace up:  Win+W
	Workspace down:  Win+S
	Move Window workspace up: Win+Shift+W
	Move Window workspace down: Win+Shift+S

	show all applications: Win+A
	Close Window: Win+Q
	Lock screen: Win+Esc

	- Custom
	gnome-system-monitor: ctrl+shift+esc
	gnome-terminal: Win+T
	nautilus: Win+F

- Firefox user chrome
/home/realgrm/.var/app/org.mozilla.firefox/.mozilla/firefox/lfmsbrd5.default-release-2/chrome
https://github.com/rafaelmardojai/firefox-gnome-theme
https://gist.github.com/miguelmota/61569c49332974f870c8a71fde081181
https://github.com/Timvde/UserChrome-Tweaks

- Firefox privacy
https://youtu.be/xxWXLlfqNAo
"""
