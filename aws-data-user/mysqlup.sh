#!/bin/bash

# Variables
DB_ROOT_PASSWORD="admin123"
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="admin123"

# Actualizar el sistema e instalar MySQL
sudo apt update
sudo apt upgrade -y
sudo apt install -y mysql-server

# Crear la base de datos y el usuario para WordPress con permisos limitados usando sudo
sudo mysql -u root -p"$DB_ROOT_PASSWORD" <<EOF
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT SELECT,INSERT,UPDATE,DELETE ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Configurar MySQL para aceptar conexiones remotas
sudo sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql