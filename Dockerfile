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

RUN mkdir -p /app/database /app/storage /app/public/posters /app/bootstrap/cache
RUN chmod -R 777 /app/database /app/storage /app/public/posters /app/bootstrap/cache

ENV APP_ENV=production
ENV APP_DEBUG=false
ENV DB_CONNECTION=sqlite
ENV DB_DATABASE=/app/database/database.sqlite

EXPOSE 10000

CMD sh -c "php artisan key:generate --force && php artisan migrate --force && php -S 0.0.0.0:${PORT:-10000} -t public"
