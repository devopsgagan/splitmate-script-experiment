#!/bin/bash

#Variables
PACKAGES="wget httpd unzip"
SVC="httpd"
TMPDIR="/tmp/webfiles"
URL="https://www.tooplate.com/zip-templates/2136_kool_form_pack.zip"
PACK="2136_kool_form_pack"

#setup
sudo yum install $PACKAGES -y
sudo systemctl start $SVC
sudo systemctl enable $SVC
sudo mkdir -p $TMPDIR
cd $TMPDIR
sudo wget $URL
unzip $PACK.zip
cp -r $PACK/* /var/www/html
sudo systemctl restart $SVC

#cleanup
sudo rm -rf $TMPDIR