#!/bin/bash
set -e

# Читаємо паролі з secrets
WP_DB_PASSWORD=$(cat /run/secrets/wp_db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

cd /var/www/html

# Якщо WordPress ще не встановлений
if [ ! -f wp-config.php ]; then

    # Завантажуємо WordPress
    wp core download --allow-root

    # Створюємо wp-config.php
    wp config create \
        --dbname=$WORDPRESS_DB_NAME \
        --dbuser=$WORDPRESS_DB_USER \
        --dbpass=$WP_DB_PASSWORD \
        --dbhost=$WORDPRESS_DB_HOST \
        --allow-root

    # Встановлюємо WordPress
    wp core install \
        --url=$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --skip-email \
        --allow-root

    # Створюємо другого користувача (вимагає subject)
    wp user create $WP_USER $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD \
        --role=author \
        --allow-root
fi

exec php-fpm7.4 -F
