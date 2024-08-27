#!/bin/bash

# Start MariaDB - This will start the MariaDB service, allowing it to be used by the WordPress container.
service mariadb start

# Create a new database.
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Create a new user.
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER_NAME'@'%' IDENTIFIED BY '$DB_USER_PASS';"

# Grant all privileges to the new user.
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER_NAME'@'%' IDENTIFIED BY '$DB_USER_PASS';"

# Flush the privileges. This ensures that the changes have taken effect immediately.
mysql -u root -e "FLUSH PRIVILEGES;"

# Stop MariaDB - This will stop the MariaDB service, freeing up the port for other services.
service mariadb stop

# Execute the command passed to the Docker container. In this case, it will be mysqld, which starts the MariaDB service in the foreground.
exec "$@"
