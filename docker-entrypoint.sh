#!/bin/bash
set -e

# Generar APP_KEY si no existe
php artisan key:generate --force

# Ejecutar migraciones
php artisan migrate --force

# Iniciar Apache en primer plano
exec apache2-foreground

chmod +x docker-entrypoint.sh
