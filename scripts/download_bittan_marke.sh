source ./download.sh
source ../.env

mkdir ../services/bittan_marke_frontend 2> /dev/null

install_release Fysiksektionen/bittan build.tar.gz ../services/bittan_marke_frontend $BITTAN_MARKE_VERSION
