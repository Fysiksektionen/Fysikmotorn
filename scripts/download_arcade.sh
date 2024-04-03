source ./download.sh
source ../.env

install_release Fysiksektionen/Arcade-website source ../services/arcade/ $ARCADE_VERSION

install_release Fysiksektionen/arcade-home build.tar.gz ../services/arcade/home/ $ARCADE_HOME_VERSION
ln -sf home/index.html ../services/arcade/index.html
