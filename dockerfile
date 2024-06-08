FROM debian:buster


RUN apt update && apt upgrade -y
RUN apt-get -y install wget

# apt install apache2 -y

# apt-get install --reinstall systemd

# systemctl enable apache2 && sudo systemctl start apache2