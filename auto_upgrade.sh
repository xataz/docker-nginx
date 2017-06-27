#!/bin/bash

NGINX_MAINLINE_VERSION=$(grep "NGINX_VER=" mainline/Dockerfile | cut -d"=" -f2)
NEW_NGINX_MAINLINE_VERSION=$(curl http://nginx.org/en/download.html 2> /dev/null | sed 's|>|>\n|g' | grep '^<a href="/download/nginx-' | head -1 | sed 's|.*nginx-\(.*\).tar.gz.*|\1|')
NGINX_STABLE_VERSION=$(grep "NGINX_VER=" stable/Dockerfile | cut -d"=" -f2)
NEW_NGINX_STABLE_VERSION=$(curl http://nginx.org/en/download.html 2> /dev/null | sed 's|>|>\n|g' | grep '^<a href="/download/nginx-' | head -3 | tail -1 | sed 's|.*nginx-\(.*\).tar.gz.*|\1|')


f_gen_tag() {
    VERSION=$1

    TAGS="$2 ${VERSION} $(echo ${VERSION} | cut -d'.' -f '1 2')"
}

f_maj_dockerfile() {
    BUILD_VER=$(date +%Y%m%d01)

    ## Edit dockerfile
    sed -i 's/NGINX_VER=.*/NGINX_VER='$2'/;
        s/tags=".*"/tags="'"${TAGS}"'"/;
        s/build_ver=".*"/build_ver="'${BUILD_VER}'"/' $1/Dockerfile
}

f_maj_readme() {
    VERSION=$1
    TAGS=$(echo $TAGS | sed 's/ /, /g')

    sed -i 's#\* .*'$1'/Dockerfile)#\* '"${TAGS}"' \[(Dockerfile)\](https://github.com/xataz/dockerfiles/blob/master/mginx/'$1'/Dockerfile)#' README.md
}

if [ "${NGINX_MAINLINE_VERSION}" != "${NEW_NGINX_MAINLINE_VERSION}" ]; then
    echo "Update nginx mainline to ${NEW_NGINX_MAINLINE_VERSION}"
    f_gen_tag ${NEW_NGINX_MAINLINE_VERSION} "latest mainline"
    f_maj_dockerfile "mainline" ${NEW_NGINX_MAINLINE_VERSION}
    f_maj_readme "mainline"
fi

if [ "${NGINX_STABLE_VERSION}" != "${NEW_NGINX_STABLE_VERSION}" ]; then
    echo "Update nginx stable to ${NEW_NGINX_STABLE_VERSION}"
    f_gen_tag ${NEW_NGINX_STABLE_VERSION} "stable"
    f_maj_dockerfile "stable" ${NEW_NGINX_STABLE_VERSION}
    f_maj_readme "stable"
fi