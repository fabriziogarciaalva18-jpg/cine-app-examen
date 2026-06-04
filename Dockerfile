FROM node:22-alpine AS frontend
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM php:8.4-cli-alpine

RUN apk add --no-cache sqlite-dev && docker-php-ext-install pdo pdo_sqlite

WORKDIR /app
COPY . /app
COPY --from=frontend /app/public/build /app/public/build
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev --optimize-autoloader --no-interaction

# Crear TODAS las carpetas necesarias
RUN mkdir -p /app/database \
    /app/storage/framework/views \
    /app/storage/framework/cache/data \
    /app/storage/framework/sessions \
    /app/storage/logs \
    /app/public/posters \
    /app/bootstrap/cache

# Permisos
RUN chmod -R 777 /app/database \
    /app/storage \
    /app/public/posters \
    /app/bootstrap/cache

# Crear .env
RUN echo "APP_NAME=CineAdmin" > /app/.env && \
    echo "APP_ENV=production" >> /app/.env && \
    echo "APP_KEY=" >> /app/.env && \
    echo "APP_DEBUG=false" >> /app/.env && \
    echo "APP_URL=https://cine-admin-uv5s.onrender.com" >> /app/.env && \
    echo "DB_CONNECTION=sqlite" >> /app/.env && \
    echo "DB_DATABASE=/app/database/database.sqlite" >> /app/.env && \
    echo "LOG_CHANNEL=stderr" >> /app/.env

EXPOSE 10000

CMD php artisan key:generate --force && \
    php artisan config:cache && \
    php artisan migrate --force && \
    php -S 0.0.0.0:${PORT:-10000} -t public
