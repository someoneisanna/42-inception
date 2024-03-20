#!/bin/bash

service php7.4-fpm start

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

WP_URL="ataboada.42.fr"
WP_TITLE="Inception"
WP_ADM_USER="root_user"
WP_ADM_PASSWORD="password"
WP_ADM_EMAIL="root_user@42.com"
WP_USER="user"
WP_USER_EMAIL="user@42.com"
WP_USER_ROLE="editor"
WP_USER_PASSWORD="password"

cd /var/www/wordpress

wp config create \
		--dbname=db_wordpress \
		--dbuser=user \
		--dbpass=user_password \
		--dbhost=localhost \
		--allow-root \
		--extra-php <<PHP
define( 'WP_HOME', '$WP_URL' );
define( 'WP_SITEURL', '$WP_URL' );
PHP

if ! wp core is-installed --allow-root; then
	wp core download --allow-root
	wp core install \
			--url=$WP_URL \
			--title=$WP_TITLE \
			--admin_user=$WP_ADM_USER \
			--admin_password=$WP_ADM_PASSWORD \
			--admin_email=$WP_ADM_EMAIL \
			--skip-email --allow-root
fi

wp --path=/var/www/wordpress user create $WP_USER $WP_USER_EMAIL \
		--role=$WP_USER_ROLE \
		--user_pass=$WP_USER_PASSWORD --allow-root

service php7.4-fpm stop

