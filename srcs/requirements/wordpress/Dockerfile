FROM debian:bullseye

RUN apt-get update && apt-get -y install \
    wget \
    curl \
    bash \
    php7.4 \
    php7.4-cgi \
    php7.4-mysql \
    php7.4-fpm \
    php7.4-pdo \
    php7.4-gd php7.4-cli \
    php7.4-mbstring \
    redis \
    php-redis \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y netcat-traditional

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir /run/php

COPY ./conf/auto_config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/auto_config.sh

ENTRYPOINT [ "/usr/local/bin/auto_config.sh" ]

#COPY ./conf/wp-config.php /var/www/html/


WORKDIR /var/www/html/
EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
