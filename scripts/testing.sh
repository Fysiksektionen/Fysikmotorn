#!/bin/bash
cd /Fysikmotorn/scripts/
echo "this is the test script"
echo $(pwd)
echo $(whoami)
source ./backup.sh
echo "we have source"
cd ..
echo $(pwd)
FILES="services/fn-crm"
NAME="fn-crm"

upload_backup ${NAME} ${FILES}
echo "uploads???"
