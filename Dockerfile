FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM php:8.3-cli-alpine

RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    oniguruma-dev \
    sqlite-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_sqlite gd mbstring

WORKDIR /app

COPY . /app
COPY --from=build /app/public/build /app/public/build

COPY composer.json composer.lock /app/
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Crear carpetas y permisos
RUN mkdir -p /var/data/posters /app/public
RUN ln -s /var/data/posters /app/public/posters
RUN chmod -R 777 /var/data /app/public/posters

# Variables de entorno
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV DB_CONNECTION=sqlite
ENV DB_DATABASE=/var/data/database.sqlite

EXPOSE 10000

# Comando de arranque con generación de clave y migración
CMD php artisan key:generate --force && \
    php artisan migrate --force && \
    php artisan serve --host=0.0.0.0 --port=${PORT:-10000}
