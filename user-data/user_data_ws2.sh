#!/bin/bash
sudo apt update -y
sudo apt install -y apache2
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
region=`curl http://169.254.169.254/latest/dynamic/instance-identity/document | grep availabilityZone`
echo "<h2>Hello</h2><h3>This is second ws for IT Syndicate</h3><h3>IP: <i color='red'>$myip</i></h3><h3>$region</h3><br/>Build by Terraform" > /var/www/html/index.html
sudo service apache2 start