# Docker + Centos + LAMP + GIT + DRUSH + Composer + powerstack + ssh

# Go version (client): go1.2.1
# Git commit (client): 867b2a9/0.9.1
# Server version: 0.9.1
# Git commit (server): 867b2a9/0.9.1
# Go version (server): go1.2.1


FROM centos:6.4
MAINTAINER Isaac Gasi <isaac.gasi@gmail.com>

# install http
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

#Lastest version LAMP
RUN rpm -Uvh http://powerstack.org/powerstack-release.rpm

# install httpd
RUN yum -y install httpd vim-enhanced bash-completion unzip

# install mysql
RUN yum install -y mysql mysql-server
RUN echo "NETWORKING=yes" > /etc/sysconfig/network
# start mysqld to create initial tables
RUN service mysqld start

# install php
RUN yum install -y php php-mysql php-devel php-gd php-pspell php-snmp php-xmlrpc php-xml

# install supervisord
RUN yum install -y python-pip && pip install "pip>=1.4,<1.5" --upgrade
RUN pip install supervisor

# install git
RUN yum install -y git-core

#install composer
RUN cd /opt/
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

#install drush
#RUN yum install -y php-drush-drush
RUN git clone https://github.com/drush-ops/drush.git /etc/drush
RUN chmod u+x /etc/drush/drush
RUN ln -s /etc/drush/drush /usr/bin/drush
RUN which drush
RUN cd /etc/drush/ && composer install

# install sshd
RUN yum install -y openssh-server openssh-clients passwd

RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key 
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && echo 'root:changeme' | chpasswd

#Shared folder
VOLUME ["/home/igasi/projects/opensource/centos-lamp/www/", "/var/www/html/", "rw"]

#ADD phpinfo.php /var/www/html/
ADD supervisord.conf /etc/
EXPOSE 22 80
CMD ["supervisord", "-n"]
