#!/bin/bash

# Wait for MariaDB to be ready
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 5
done

# Check if wp-config.php already exists
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    # Configuration file doesn't exist, create it
    wp config create --allow-root \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST:3306" \  # Use TCP/IP connection with port 3306
        --path="/var/www/wordpress"
else
    echo "WordPress configuration file already exists, skipping configuration."
fi

