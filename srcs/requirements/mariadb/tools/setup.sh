#!/bin/bash

# Start MariaDB service
# This is necessary to create the database and user.
service mariadb start

#Create a new database if it doesn't already exist.
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Create a new MySQL user if it doesn't already exist.
# The user is given access from any host ('%').
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER_NAME'@'%' IDENTIFIED BY '$DB_USER_PASS';"

# Grant all privileges on the new database to the new user.
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER_NAME'@'%' IDENTIFIED BY '$DB_USER_PASS';"

# Flush privileges to ensure all privilege changes take effect immediately.
mysql -u root -e "FLUSH PRIVILEGES;"

# Stop the MariaDB service
# This is done to free up the MySQL port and allow the main MariaDB process to 
# start later.
service mariadb stop

# Execute the command passed to the Docker container.
# In this case, it will be mysqld, which starts the MariaDB service in the
# foreground. Using exec replaces the current shell with the mysqld process.
exec "$@"
