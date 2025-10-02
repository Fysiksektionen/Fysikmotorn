#!/bin/bash
source ../../download.sh
source .env

mkdir ../../services/bittan_marke_frontend 2> /dev/null

install_release fysiksektionens-naringslivsnamnd/hemsida build.tar.gz ../../services/fnkth.se $FNKTHSE_VERSION
