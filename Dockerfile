FROM node:22-alpine AS frontend-builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM php:8.4-apache

# Instalar dependencias y extensión SQLite
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_sqlite

# Habilitar mod_rewrite para Laravel
RUN a2enmod rewrite

# Configurar Apache para servir desde /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Configurar el DocumentRoot a la carpeta public de Laravel
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

# Copiar Composer desde la imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copiar el código de la aplicación
COPY . .

# Copiar los assets compilados desde el frontend-builder
COPY --from=frontend-builder /app/public/build ./public/build

# Instalar dependencias de Composer
RUN composer install --no-dev --optimize-autoloader

# Crear carpetas necesarias y dar permisos
RUN mkdir -p /var/www/html/database \
    /var/www/html/storage/logs \
    /var/www/html/storage/framework/views \
    /var/www/html/storage/framework/cache \
    /var/www/html/storage/framework/sessions \
    /var/www/html/storage/app/public \
    /var/www/html/bootstrap/cache \
    /var/www/html/public/posters

RUN chmod -R 777 /var/www/html/database \
    /var/www/html/storage \
    /var/www/html/bootstrap/cache \
    /var/www/html/public/posters

RUN chown -R www-data:www-data /var/www/html

# Copiar el entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Variables de entorno
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV DB_CONNECTION=sqlite
ENV DB_DATABASE=/var/www/html/database/database.sqlite

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
