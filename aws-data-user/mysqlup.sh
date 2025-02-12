#!/bin/bash

# Variables
$DB_ROOT_PASSWORD="admin123"
$DB_NAME="wordpress"
$DB_USER="wordpress"
$DB_PASSWORD="admin123"

# Actualizar el sistema e instalar MySQL
sudo apt update
sudo apt upgrade -y
sudo apt install -y mysql-server

# Configurar la contraseña de root de MySQL
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'admin123' BY '$DB_ROOT_PASSWORD';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Crear la base de datos y el usuario para WordPress
sudo mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE DATABASE $DB_NAME;"
sudo mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
sudo mysql -u root -p$DB_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
sudo mysql -u root -p$DB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# Configurar MySQL para aceptar conexiones remotas
sudo sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

echo "Instalación de MySQL completada. Asegúrate de configurar tu firewall para permitir conexiones a MySQL."