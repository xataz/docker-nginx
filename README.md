![](http://nginx.org/nginx.png)

> This image is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
> If you don't trust, you can build yourself.

## Tag available
* latest, mainline, 1.13.2, 1.13 [(Dockerfile)](https://github.com/xataz/dockerfiles/blob/master/mginx/mainline/Dockerfile)
* stable, 1.12.0, 1.12 [(Dockerfile)](https://github.com/xataz/dockerfiles/blob/master/mginx/stable/Dockerfile)

## Description
What is [Nginx](http://nginx.org)?

nginx (engine x) is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP proxy server, originally written by Igor Sysoev. For a long time, it has been running on many heavily loaded Russian sites including Yandex, Mail.Ru, VK, and Rambler. According to Netcraft, nginx served or proxied 24.29% busiest sites in December 2015. Here are some of the success stories: Netflix, Wordpress.com, FastMail.FM.

**This image not contains root process**

## Build Image
### Build arguments
* NGINX_CONF : Nginx make configure options
* NGINX_VER : Nginx version
* ARG NGINX_GPG : GPG fingerprint (default : "B0F4253373F8F6F510D42178520A9993A1C052F8")
* ARG BUILD_CORES : Number of core use for make nginx (default : All cores)

# Simply build
```shell
docker build -t xataz/nginx github.com/xataz/dockerfiles.git#master:nginx/mainline
```
### Build other version
```shell
docker build -t xataz/nginx --build-arg NGINX_VER=1.9.5 github.com/xataz/dockerfiles.git#master:nginx/mainline
```

## Configuration
### Environments
* UID : Choose uid for launch nginx (default : 991)
* GID : Choose gid for launch nginx (default : 991)

### Volumes
* /nginx/sites-enabled : Place your vhost here
* /nginx/log : Log emplacement
* /nginx/run : Here is pid and lock file
* /nginx/conf/nginx.conf : General configuration of nginx

### Ports
* 8080
* 8443

## Usage
### Advanced launch
```shell
docker run -d \
	-p 80:8080 \
	-p 443:8443 \
	-v /docker/config/nginx/www/html:/nginx/www/html \
	-v /docker/config/nginx/sites-enabled:/sites-enabled \
	xataz/nginx:mainline
```

## Contributing
Any contributions, are very welcome !