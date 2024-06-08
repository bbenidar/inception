FROM debian:bullseye

# Update package lists and install basic packages
RUN apt-get update && apt-get upgrade -y

RUN apt-get -y install wget


ENV SQL_DATABASE=root
ENV SQL_USER=root
ENV SQL_PASSWORD=bbenidar
ENV SQL_ROOT_PASSWORD=root

RUN apt-get install -y php7.3\
						php-fpm\
						php-mysql\
						mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www

RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
# Add Sury PHP repository

RUN		chown -R root:root /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN apt-get install -y netcat



COPY conf/auto_config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/auto_config.sh

ENTRYPOINT ["/usr/local/bin/auto_config.sh"]

CMD ["/usr/sbin/php-fpm7.3", "-F"]