#!/bin/bash

#setup
sudo yum install wget httpd unzip -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo mkdir -p /tmp/webfiles
cd /tmp/webfiles
sudo wget https://www.tooplate.com/zip-templates/2136_kool_form_pack.zip
unzip 2136_kool_form_pack.zip
cp -r 2136_kool_form_pack/* /var/www/html
sudo systemctl restart httpd

#cleanup
sudo rm -rf /tmp/webfiles