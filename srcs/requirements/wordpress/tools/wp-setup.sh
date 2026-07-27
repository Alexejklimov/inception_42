#!/bin/bash
set -e

WP_DB_PASSWORD=$(cat /run/secrets/wp_db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

cd /var/www/html

mkdir -p /run/php

DB_HOST=${WORDPRESS_DB_HOST%:*}
DB_PORT=${WORDPRESS_DB_HOST##*:}
if [ "$DB_HOST" = "$DB_PORT" ]; then
    DB_PORT=3306
fi

until mysqladmin ping -h "$DB_HOST" -P "$DB_PORT" -u "$WORDPRESS_DB_USER" -p"$WP_DB_PASSWORD" --silent; do
    echo "Waiting for MariaDB at $DB_HOST:$DB_PORT..."
    sleep 2
done

if [ ! -f wp-config.php ]; then
    if [ ! -f wp-settings.php ]; then
        wp core download --allow-root
    fi

    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WP_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root
fi

if ! wp core is-installed --allow-root; then
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --allow-root
fi

exec php-fpm8.2 -F
