#!/bin/bash

# Start the MySQL service
service mariadb start

# # Wait for the MySQL service to start

# Wait for the MySQL service to start
while ! mysqladmin ping -h localhost --silent; do
    sleep 1
done

# # Set the MySQL root password
mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${SQL_ROOT_PASSWORD}');"

#creat database for wordpress
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# # Start the MySQL service




# # Create the database
# mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# # Create the user
# mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# # Grant privileges to the user
# mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# # Change the root user password
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# # Flush privileges
# mysql -e "FLUSH PRIVILEGES;"

# # Shutdown the MySQL service
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Start the MySQL service again
exec mysqld_safe