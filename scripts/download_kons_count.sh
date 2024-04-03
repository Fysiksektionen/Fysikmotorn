source ./download.sh
source ../.env

install_release Fysiksektionen/kons_count build.tar.gz ../services/kons-count/static/ $KONS_COUNT_VERSION
