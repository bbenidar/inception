#!/bin/sh

# Initialize MariaDB data directory
mysql_install_db

# Start the MariaDB service
/etc/init.d/mysql start

# Check if the database exists
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then 
    echo "Database already exists"
else
    # Set root password and perform secure installation
    echo "Initializing MariaDB..."
    service mariadb start
    mysql_secure_installation <<_EOF_
y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
y
n
y
y
_EOF_

    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREAT DATABASE $MYSQL_DATABASE;"
    # Add root user for remote connections and flush privileges
    echo "Granting privileges..."
    echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

    # Create database and user for WordPress
    echo "Creating WordPress database and user..."
    echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root

    # Import WordPress SQL script
    echo "Importing WordPress database..."
    mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql
fi

# Stop the MariaDB service
/etc/init.d/mysql stop

# Execute any additional command specified
exec "$@"

