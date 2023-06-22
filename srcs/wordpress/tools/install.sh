#!/bin/sh

set -eux

#MariaDB must be launched already
sleep 5

cd /var/www/wordpress

if [ -f /var/www/wordpress/wp-config.php ]; then
    echo "Already created."
    exec /usr/sbin/php-fpm81 -F
    exit 1
fi

# "bootstrap" Wordpress
wp config create --allow-root \
                 --dbname="${DB_NAME}" \
                 --dbuser="${DB_USR}" \
                 --dbpass="${DB_PWD}" \
                 --dbhost=mariadb:3306 \
                 --path='/var/www/wordpress'
wp db create
wp core install \
    --url="lrandria.42.fr" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_NAME}" \
    --admin_password="${WP_ADMIN_PWD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --skip-email
wp user create "${WP_USR_NAME}" "${WP_USR_EMAIL}" \
    --user_pass="${WP_USR_PWD}" \
    --porcelain

exec /usr/sbin/php-fpm81 -F