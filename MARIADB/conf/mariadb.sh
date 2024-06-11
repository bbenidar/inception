#!/bin/bash
# Start the MySQL service
service mariadb start

# Wait for the MySQL service to start
while ! mysqladmin ping -h localhost --silent; do
    sleep 1
done

# Set the MySQL root password
mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${SQL_ROOT_PASSWORD}');"

# Create database for WordPress
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Execute the WordPress SQL script
mysql < /usr/local/bin/wordpress.sql

# Shutdown the MySQL service
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Start the MySQL service again
exec mysqld_safe