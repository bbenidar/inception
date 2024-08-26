#!/bin/sh

#wait for mariadb to start
if ! nc -z $MYSQL_HOSTNAME 3306; then
    echo "Waiting for MariaDB to start..."
    while ! nc -z $MYSQL_HOSTNAME 3306; do
        sleep 0.1
    done
    echo "MariaDB started"
fi

# check if wp-config.php exists
# if [ -f ./wp-config.php ]; then
#     rm -rf wp-config.php
# fi

if [ ! -f ./wp-config.php ]; then
    rm -rf ./*

    # Download WordPress and all config files
    wget http://wordpress.org/latest.tar.gz
    tar xfz latest.tar.gz
    mv -f wordpress/* .
    rm -rf latest.tar.gz
    rm -rf wordpress
    echo "WordPress downloaded"

    # Edit wp-config.php
    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
    sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config.php
    sed -i "s/utf8/utf8mb4/g" wp-config.php

    # Update site URL using sed
    # sed -i "s|define('WP_HOME', '.*');|define('WP_HOME', 'https://bbenidar.42.fr');|g" wp-config.php
    # sed -i "s|define('WP_SITEURL', '.*');|define('WP_SITEURL', 'https://bbenidar.42.fr');|g" wp-config.php

    echo "---------------------------------------"
    cat wp-config.php
    echo "------------------------------------"

    # Create WordPress users
    wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root 
    wp user create $WP_ADMIN_USER $WP_ADMIN_EMAIL --user_pass=$WP_ADMIN_PASSWORD --role=administrator --allow-root
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=author --allow-root

    # Install WordPress
fi

exec "$@"
