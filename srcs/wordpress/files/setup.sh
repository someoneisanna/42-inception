#!/bin/bash

sleep 7

service php7.4-fpm start

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress

wp core install \
		--url=$WP_URL \
		--title=$WP_TITLE \
		--admin_user=$WP_ADM_USER \
		--admin_password=$WP_ADM_PASSWORD \
		--admin_email=$WP_ADM_EMAIL \
		--skip-email \
		--allow-root

if ! wp user list --field=user_login --allow-root | grep -q "^$WP_USER$"; then
	wp user create $WP_USER $WP_USER_EMAIL \
		--role=$WP_USER_ROLE \
		--user_pass=$WP_USER_PASSWORD --allow-root
fi

service php7.4-fpm stop

exec "$@"
