# Base Image
FROM nginx:alpine

# Install PHP and extensions
RUN apk add --no-cache php8 php8-fpm php8-mysqli php8-gettext php8-mbstring php8-gd php8-json php8-session

# Configure PHP-FPM
RUN mkdir -p /run/php && \
    sed -i 's/;daemonize = yes/daemonize = no/' /etc/php8/php-fpm.conf

# Copy your custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy website files
COPY web /usr/share/nginx/html

# Expose ports
EXPOSE 80

# Start both Nginx and PHP-FPM
CMD php-fpm8 -D && nginx -g "daemon off;"
