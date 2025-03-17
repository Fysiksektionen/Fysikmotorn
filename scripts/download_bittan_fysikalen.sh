source ./download.sh
source ../.env

mkdir ../services/bittan_fysikalen_frontend 2> /dev/null

install_release Fysiksektionen/bittan build.tar.gz ../services/bittan_fysikalen_frontend $BITTAN_FYSIKALEN_VERSION
