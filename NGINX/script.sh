#!/bin/bash

CERTS_PATH=/etc/ssl/certs/nginx-selfsigned.crt
DOMAIN_NAME=bbenidar.1337.ma



openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out $CERTS_ -subj "/C=MO/L=KH/O=1337/OU=student/CN=localhost"

echo "
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name localhost;

    ssl_certificate $CERTS_;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;" > /etc/nginx/sites-available/default


echo '
    ssl_protocols TLSv1.3;

    index index.php;
    root /var/www/html;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
            fastcgi_pass wordpress:9000;
            fastcgi_intercept_errors on;
            include snippets/fastcgi-php.conf;
        }
} ' >>  /etc/nginx/sites-available/default

# echo "<!DOCTYPE html>
# <html>
#   <head>
#     <title>Hello World</title>
#   </head>
#   <body>
#     <h1>Hello World</h1>
#   </body>
# </html>" > /var/www/html/index.html

chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

nginx -g "daemon off;"
