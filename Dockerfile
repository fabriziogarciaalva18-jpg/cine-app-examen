# Etapa 1: Compilar assets con Node
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
# Usamos npm install en lugar de npm ci para evitar problemas con lockfile
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: PHP (usamos 8.3 que es estable y oficial)
FROM php:8.3-cli-alpine

# Instalar extensiones necesarias para Laravel y SQLite
RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    oniguruma-dev \
    sqlite-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_sqlite gd mbstring

WORKDIR /app

# Copiar código de la aplicación
COPY . /app

# Copiar assets compilados desde la etapa anterior
COPY --from=build /app/public/build /app/public/build

# Instalar Composer y dependencias PHP de producción
COPY composer.json composer.lock /app/
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Preparar carpeta de datos persistentes y enlace simbólico para posters
RUN mkdir -p /var/data/posters /app/public
RUN ln -s /var/data/posters /app/public/posters
RUN chmod -R 777 /var/data

# Variables de entorno por defecto (Render las sobrescribirá si las defines en el panel)
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV DB_CONNECTION=sqlite
ENV DB_DATABASE=/var/data/database.sqlite

EXPOSE 10000

# Comando de arranque: migrar y servir
CMD php artisan migrate --force && \
    php artisan serve --host=0.0.0.0 --port=${PORT:-10000}
