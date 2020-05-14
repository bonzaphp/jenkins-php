# 自定义Jenkins镜像

### Debian

**安装软件源拓展工具：**

```bash
apt -y install software-properties-common apt-transport-https lsb-release ca-certificates
```

**添加 GPG**

```bash
wget -O /etc/apt/trusted.gpg.d/php.gpg https://mirror.xtom.com.hk/sury/php/apt.gpg
```

**添加 sury 软件源**

```bash
sh -c 'echo "deb https://mirror.xtom.com.hk/sury/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'   
```

**更新软件源缓存：**

```bash
apt-get update
```

## 安装软件

**安装 PHP7.3：**

```bash
apt install php7.3-fpm php7.3-mysql php7.3-curl php7.3-gd php7.3-mbstring php7.3-xml php7.3-xmlrpc php7.3-zip php7.3-opcache -y

```

## 设置 PHP

安装完成后，编辑 `/etc/php/7.3/fpm/php.ini` 替换换 `;cgi.fix_pathinfo=1` 为 `cgi.fix_pathinfo=0` 快捷命令：

```bash
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/7.3/fpm/php.ini 
```

## 管理 PHP