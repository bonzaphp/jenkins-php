FROM jenkins/jenkins:lts
MAINTAINER bonzaphp <bonzaphp@gmail.com>
# jenkins默认使用账户是Jenkins，我们使用root账户便于安装其他软件
USER root

ENV DEBIAN_FRONTEND noninteractive


RUN  mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY $PWD/sources.list /etc/apt/

#添加composer命令到容器中
COPY composer.phar /usr/local/bin/composer
# 安装PHP相关软件包
RUN apt-get update \
&& apt -y install software-properties-common apt-transport-https lsb-release ca-certificates \
&& wget -O /etc/apt/trusted.gpg.d/php.gpg https://mirror.xtom.com.hk/sury/php/apt.gpg \
&& sh -c 'echo "deb https://mirror.xtom.com.hk/sury/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' \
#RUN apt-get -y -f install software-properties-common apt-transport-https lsb-release ca-certificates && add-apt-repository ppa:ondrej/php
&& apt-get update \
&& apt-get -y -f install build-essential g++ php7.2-cli php7.2-curl php7.2-dev curl php-pear php-xml php7.2-xml php7.2-mbstring dialog \
&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
# 清理缓存，减小镜像大小
&& apt-get clean -y \
# 安装swoole扩展
&& pecl install swoole \
# 编辑php.ini文件
&& echo extension=swoole.so >> /etc/php/7.2/cli/php.ini \
# 给composer文件添加执行权限
&& chmod +x /usr/local/bin/composer
# 返回Jenkins用户
USER jenkins
