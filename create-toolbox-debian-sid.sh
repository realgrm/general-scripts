#!/bin/sh

RELEASE=${1:-latest}
DISTRO=${2:-ubuntu}

toolbox rm -f $RELEASE
toolbox -y create -c $RELEASE --image docker.io/$DISTRO:$RELEASE

# can't do that with toolbox run yet, as we need to install sudo first
podman start $RELEASE
podman exec -it $RELEASE sh -exc '
# go-faster apt/dpkg
echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/unsafe-io

# location based redirector gets it wrong with company VPN; also add deb-src
sed -i "s/deb.debian.org/ftp.de.debian.org/; /^deb\b/ { p; s/^deb/deb-src/ }" /etc/apt/sources.list

apt-get update
apt-get install -y libnss-myhostname sudo eatmydata libcap2-bin

# allow sudo with empty password
sed -i "s/nullok_secure/nullok/" /etc/pam.d/common-auth
'

toolbox run --container $RELEASE sh -exc '
# otherwise installing systemd fails
sudo umount /var/log/journal

# useful hostname
. /etc/os-release
echo "${ID}-${VERSION_ID:-sid}"
sudo hostname -F /etc/hostname

sudo eatmydata apt-get -y dist-upgrade

# development tools
sudo eatmydata apt-get install -y --no-install-recommends build-essential git-buildpackage libwww-perl less vim lintian debhelper manpages-dev git dput pristine-tar bash-completion wget gnupg ubuntu-dev-tools python3-debian fakeroot libdistro-info-perl
'