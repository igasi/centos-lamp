# Dockerfile and relevant configuration to host a LAMP stack on centos using supervisor

##Features

Centos 6.4
powerstack
php5.4+
mysql
httpd
sshd
drush
git
composer
Devepment tools
Xdebug

## to build

sudo docker build -t yourproject/centoslamp .

## to run 
sudo docker run -i -v /path/absolute/local/to/share/:/path/into/docker:ro|rw -t yourproject/centoslamp /bin/bash

example

sudo docker run -i -v /home/user/project/drupal8/:/var/www/html:rw -t drupal8/centoslamp /bin/bash

## to show in browser

http://172.17.0.2/
http://172.17.0.2/phpinfo.php



ToDo

Config Xdedug (Currently only install)
Add puppet
