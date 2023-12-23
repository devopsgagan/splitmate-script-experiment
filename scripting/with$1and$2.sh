#!/bin/bash

#Variables
PACKAGES="wget httpd unzip"
SVC="httpd"
TMPDIR="/tmp/webfiles"

###commenting so that I can use any tootplate wesite template
### URL="https://www.tooplate.com/zip-templates/2136_kool_form_pack.zip"
### PACK="2136_kool_form_pack"

#setup
sudo yum install $PACKAGES -y
sudo systemctl start $SVC
sudo systemctl enable $SVC
sudo mkdir -p $TMPDIR
cd $TMPDIR
sudo wget $1 #URL Value has to be provided while running the script
unzip $2.zip #PACK Value has to be provided while running the script
cp -r $2/* /var/www/html
sudo systemctl restart $SVC

#cleanup
sudo rm -rf $TMPDIR

##Command: ./file URL PACK