FROM nginx:alpine
MAINTAINER Hungnv
#install php
RUN apk update --no-cache
RUN apk add \
    php7 \
    php7-fpm \
#    util-linux \
    supervisor \
    php7-session \
    php7-mbstring \
    php7-xml \
    php7-json \
    php7-curl \
    php7-phar \
    php-xml \
    composer

# check composer version
RUN /usr/bin/composer -V

COPY supervisord.conf /etc/supervisord/supervisord.conf

RUN cat /etc/supervisord/supervisord.conf

# change nginx config
COPY default.conf /etc/nginx/conf.d/default.conf


RUN mkdir -p /var/www/html

WORKDIR /var/www/html

COPY index.html .
COPY index.php .

RUN ls -la
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord/supervisord.conf"]
