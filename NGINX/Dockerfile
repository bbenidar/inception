# Use the Debian Buster base image
FROM debian:bullseye

# Update package lists and upgrade installed packages
RUN apt update && apt upgrade -y

# Install Nginx and OpenSSL
RUN apt install -y nginx openssl vim curl

# Create directories for SSL and web content
RUN mkdir -p /etc/nginx/ssl /var/www/html

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=bbenidar.42.fr/UID=bbenidar"

# Copy custom Nginx configuration
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Create a simple index.html file
# RUN echo '<html><body><h1>haa77 3la terma </h1></body></html>' > /var/www/html/index.html

# Set the correct permissions and ownership
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www

# Expose ports 80 and 443
EXPOSE 80 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
