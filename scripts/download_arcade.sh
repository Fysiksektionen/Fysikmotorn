source ./download.sh
source ../.env

mkdir ../services/arcade 2> /dev/null

install_release Fysiksektionen/Arcade-website source ../services/arcade/ $ARCADE_VERSION

install_release Fysiksektionen/arcade-home build.tar.gz ../services/arcade/home/ $ARCADE_HOME_VERSION

ln -sf home/index.html ../services/arcade/index.html
ln -s FnollsFlykt ../services/arcade/fnollsflykt
