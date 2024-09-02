#!/bin/sh


if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi


mysqld_safe --bind-address=0.0.0.0 &


sleep 5

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then 
    echo "Database already exists"
else

    echo "Initializing MariaDB..."


    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $MYSQL_DATABASE;"
    echo "Granting privileges..."
    echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

    echo "Creating WordPress database and user..."
    echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root

    echo "Importing WordPress database..."
    mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql
fi

/etc/init.d/mysql stop


exec "$@"
