FROM alpine:3.18

# Install Nginx and PHP-FPM
RUN apk add --no-cache nginx php81 php81-fpm php81-sockets

# Configure Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Configure PHP-FPM
RUN sed -i 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php\/php8-fpm.sock/g' /etc/php81/php-fpm.d/www.conf \
    && sed -i 's/;listen.owner = nobody/listen.owner = nginx/g' /etc/php81/php-fpm.d/www.conf \
    && sed -i 's/;listen.group = nobody/listen.group = nginx/g' /etc/php81/php-fpm.d/www.conf \
    && sed -i 's/nobody/nginx/g' /etc/php81/php-fpm.d/www.conf

# Create directory for PHP socket
RUN mkdir -p /var/run/php && chown nginx:nginx /var/run/php

# Copy the PHP script
COPY ssh_check.php /var/www/html/

# Set correct permissions
RUN chown -R nginx:nginx /var/www/html \
    && chmod 644 /var/www/html/ssh_check.php

# Expose port 80
EXPOSE 80

# Start Nginx and PHP-FPM
CMD ["/bin/sh", "-c", "php-fpm81 && nginx -g 'daemon off;'"]
