FROM debian:buster


RUN apt -y update && apt install -y nginx && apt install openssl -y

ENV DOMAIN_NAME=bbenidar.1337.ma
ENV CERTS_=/etc/ssl/certs/nginx-selfsigned.crt



# COPY ./conf/default /etc/nginx/sites-available/

COPY ./script.sh /
RUN chmod +x /script.sh


CMD [ "/script.sh" ]
