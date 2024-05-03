source ./download.sh
source ../.env

mkdir ../services/kons-count ../services/kons-count/static 2> /dev/null

install_release Fysiksektionen/kons_count build.tar.gz ../services/kons-count/static/ $KONS_COUNT_VERSION kons-count
