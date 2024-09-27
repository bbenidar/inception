FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/bbenidar.crt \
       -keyout /etc/nginx/ssl/bbenidar.key \
       -subj "/C=MO/L=KH/O=1337/OU=student/CN=bbenidar.42.fr"

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf
RUN mkdir -p /run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
 
