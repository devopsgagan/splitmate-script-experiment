#!/bin/bash

### This Script works for Amazon-Linux which is based on Fedora
### maven configuration

sudo yum update -y
sudo yum install git -y
sudo yum install java-17-amazon-corretto-devel -y
cd /opt/
sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
sudo tar -xzvf apache-maven-3.9.6-bin.tar.gz
sudo rm -rf apache-maven-3.9.6-bin.tar.gz
sudo mv apache-maven-3.9.6/ maven
sudo echo "export PATH=$PATH:/opt/maven/bin" >> ~/.bashrc
source ~/.bashrc
###
### tomcat configuration
cd /opt/
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz
sudo tar -xzvf apache-tomcat-9.0.84.tar.gz
sudo rm -rf apache-tomcat-9.0.84.tar.gz
sudo mv apache-tomcat-9.0.84/ tomcat
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
sudo chown -R tomcat:tomcat /opt/tomcat
###
### tomcat service configuration
sudo echo "[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
User=tomcat
Group=tomcat
Restart=always

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/tomcat.service
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
###
### tomcat server configuration
sudo sed -i '/<\/tomcat-users>/c\
<role rolename="manager-gui"/>\
<user username="tomcat" password="tomcat" roles="manager-gui"/>\
</tomcat-users>' /opt/tomcat/conf/tomcat-users.xml
###
sudo sed -i '21,22 {s/^[[:space:]]*/<!-- /; s/[[:space:]]*$/ -->/}' /opt/tomcat/webapps/manager/META-INF/context.xml
###
sudo systemctl restart tomcat
