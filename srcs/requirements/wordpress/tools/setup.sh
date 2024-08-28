#!/bin/bash

# Wait for MySQL to be ready
sleep 5

# Start PHP so we can use WP-CLI
service php7.4-fpm start

# Install WordPress CLI so that we can install WordPress
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Go to the directory where you want WordPress files to be installed in
cd /var/www/wordpress

# Install WordPress
wp core install \
		--url=$WP_URL \
		--title=$WP_TITLE \
		--admin_user=$WP_ADM_USER \
		--admin_password=$WP_ADM_PASS \
		--admin_email=$WP_ADM_EMAIL \
		--skip-email \
		--allow-root

# Create a new user if it doesn't exist already
if ! wp user list --field=user_login --allow-root | grep -q "^$WP_USER$"; then
	wp user create $WP_USER $WP_USER_EMAIL \
		--role=$WP_USER_ROLE \
		--user_pass=$WP_USER_PASS --allow-root
fi

# Install the Classic Editor plugin so that we don't have any issues when editing posts in firefox
wp plugin install classic-editor --activate --allow-root

# Stop PHP now that we're done
service php7.4-fpm stop

# Execute the CMD php-fpm7.4 --nodaemonize so that the container doesn't exit and the PHP-FPM process is kept running
exec "$@"
