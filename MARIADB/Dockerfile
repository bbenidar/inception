FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt-get install mariadb-server -y
ENV SQL_DATABASE=root
ENV SQL_USER=root
ENV SQL_PASSWORD=bbenidar
ENV SQL_ROOT_PASSWORD=root
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
EXPOSE 3306

# Set the data directory for MariaDB
ENV MYSQL_DATA_DIR=/var/lib/mysql

# Create the data directory and set permissions
RUN mkdir -p $MYSQL_DATA_DIR && \
    chown -R mysql:mysql $MYSQL_DATA_DIR

COPY ./script.sh /script.sh
RUN chmod +x /script.sh

# run the script
CMD ["/script.sh"]