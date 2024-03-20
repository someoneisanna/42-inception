#!/bin/bash

set -e

DB_NAME="database_example"
DB_USERNAME="random"
DB_PASSWORD="random"
DB_TABLE="table_example"

service mariadb start

mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "USE $DB_NAME; CREATE TABLE IF NOT EXISTS $DB_TABLE (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255) NOT NULL);"
mysql -u root -e "USE $DB_NAME; INSERT INTO $DB_TABLE (name) VALUES ('Hello, World!');"

exec "$@"
