FROM php:8.4-cli-alpine

RUN apk add --no-cache sqlite-dev nodejs npm git \
    && docker-php-ext-install pdo pdo_sqlite

WORKDIR /app

COPY . /app

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev --optimize-autoloader --no-interaction

RUN npm install && npm run build

RUN mkdir -p /app/database /app/storage /app/public/posters /app/bootstrap/cache
RUN chmod -R 777 /app/database /app/storage /app/public/posters /app/bootstrap/cache

RUN echo "APP_NAME=CineAdmin" > /app/.env
RUN echo "APP_ENV=production" >> /app/.env
RUN echo "APP_KEY=" >> /app/.env
RUN echo "APP_DEBUG=false" >> /app/.env
RUN echo "APP_URL=https://cine-admin-uv5s.onrender.com" >> /app/.env
RUN echo "DB_CONNECTION=sqlite" >> /app/.env
RUN echo "DB_DATABASE=/app/database/database.sqlite" >> /app/.env

EXPOSE 10000

CMD php artisan key:generate --force && php artisan migrate --force && php -S 0.0.0.0:${PORT:-10000} -t public
