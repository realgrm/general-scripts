# toolbox

#variables

project_folder=${HOME}/Documents/projects
toolbox_name=f34gs

REPOS=(
    libgweather
    gsettings-desktop-schemas
    mutter
    gtk
	clutter
    gnome-shell
)

# outside the toolbox
#toolbox create --release 34 ${toolbox_name}
#toolbox enter ${toolbox_name}

# preparing for building
sudo dnf upgrade -y
sudo dnf install  -y dbus-daemon
sudo dnf builddep -y ${REPOS[@]}

# building
mkdir -p ${project_folder}

for repo in ${REPOS[@]}; do

    cd ${project_folder}

    if [ ${repo}!=gnome-shell ]

    then 
        git clone https://gitlab.gnome.org/GNOME/${repo}.git
        
        mkdir ${project_folder}/${repo}/build
        cd ${project_folder}/${repo}/build
        
        meson --prefix=/usr
        ninja
        sudo ninja install

    else
        git clone https://gitlab.gnome.org/feaneron/gnome-shell.git
        cd ${project_folder}/${repo}
        git checkout gbsneto/40-stuff

        mkdir ${project_folder}/${repo}/build
        cd ${project_folder}/${repo}/build
        
        meson --prefix=/usr
        ninja
        sudo ninja install
    fi
done

MUTTER_DEBUG_DUMMY_MODE_SPECS=1920x1080 WAYLAND_DISPLAY=wayland-1 dbus-run-session -- gnome-shell --nested --wayland