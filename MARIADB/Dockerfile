FROM debian:bullseye
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client vim && \
    rm -rf /var/lib/apt/lists/*

# Allow to run the daemon of MySQL
# Purge and re-create /var/lib/mysql with appropriate ownership
# Ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

EXPOSE 3306

# Copy the mariadb.sh script and the wordpress.sql file
COPY ./tools/mariadb.sh /usr/local/bin/
COPY ./conf/wordpress.sql /usr/local/bin/

# Make the scripts executable
RUN chmod +x /usr/local/bin/mariadb.sh && \
    chmod +x /usr/local/bin/wordpress.sql
RUN service mariadb start
# Set the entrypoint to execute the mariadb.sh script
ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

# Command to launch MariaDB and enable the database to listen globally
CMD ["mysqld", "--bind-address=0.0.0.0"]
