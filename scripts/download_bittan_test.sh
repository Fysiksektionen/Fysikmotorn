source ./download.sh
source ../.env

mkdir ../services/bittan_test_frontend 2> /dev/null

install_release Fysiksektionen/bittan build.tar.gz ../services/bittan_test_frontend f0.0.5
