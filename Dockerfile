FROM nginx:latest
MAINTAINER jack <wangxichao001@gmail.com>
WORKDIR /usr/share/nginx/html
ADD build /usr/share/nginx/html
COPY mysite.template /etc/nginx/conf.d/