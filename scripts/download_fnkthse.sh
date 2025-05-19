source ./download.sh
source ../.env

mkdir ../services/bittan_marke_frontend 2> /dev/null

install_release zl2noob/fn-hemsida build.tar.gz ../services/fnkth.se $BITTAN_MARKE_VERSION
# TODO change organisation and repo name to FN's
