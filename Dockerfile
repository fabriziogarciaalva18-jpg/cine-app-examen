# 1. Frontend assets pipeline compilation
FROM node:22-alpine AS frontend-builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# 2. Server setup using fully supported production PHP 8.4
FROM php:8.4-apache

# Install required Linux structural utilities and SQLite drivers
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_sqlite

# Point the server document configurations straight to public/
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN a2enmod rewrite

# Install up-to-date Composer binaries
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . .

# Extract the Vue JavaScript build files
COPY --from=frontend-builder /app/public/build ./public/build

# Optimize PHP package setups
RUN composer install --no-dev --optimize-autoloader

# Create required project operational folders
RUN mkdir -p /var/www/html/database \
             /var/www/html/storage/logs \
             /var/www/html/storage/framework/views \
             /var/www/html/storage/framework/cache \
             /var/www/html/storage/framework/sessions \
             /var/www/html/storage/app/public \
             /var/www/html/bootstrap/cache \
             /var/www/html/public/posters

# Guarantee complete write-access permissions for SQLite and media folders
RUN chmod -R 777 /var/www/html/database /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/public/posters
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
