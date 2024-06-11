#!/bin/sh

#check if wp-config.php exist
# if [ -f ./wp-config.php ] remove it and download a new one
# if [ -f ./wp-config.php ]
# then
# 	rm -rf wp-config.php
# fi
if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else
	rm -rf ./*
	#Download wordpress and all config file
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv -f wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress
	echo "wordpress downloaded"
	# adite wp-config.php
	cp wp-config-sample.php wp-config.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
	sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config.php
	sed -i "s/utf8/utf8mb4/g" wp-config.php
	echo "---------------------------------------"
	cat wp-config.php
	echo "---------------------------------------"
	# create user 
	wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
	wp user create $WP_USER $WP_USER_EMAIL  --user_pass=$WP_USER_PASSWORD --role=author --allow-root
fi


exec "$@"