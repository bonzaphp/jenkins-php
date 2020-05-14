FROM jenkins/jenkins:lts
MAINTAINER bonzaphp <bonzaphp@gmail.com>
# jenkins默认使用账户是Jenkins，我们使用root账户便于安装其他软件
USER root

# 安装PHP相关软件包
RUN apt-get update
RUN apt -y install software-properties-common apt-transport-https lsb-release ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://mirror.xtom.com.hk/sury/php/apt.gpg
RUN sh -c 'echo "deb https://mirror.xtom.com.hk/sury/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
#RUN apt-get -y -f install software-properties-common apt-transport-https lsb-release ca-certificates && add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get -y -f install php7.2-cli php7.2-curl php7.2-dev curl php-pear ant
# 清理缓存，减小镜像大小
RUN apt-get clean -y

# 返回Jenkins用户
USER jenkins
