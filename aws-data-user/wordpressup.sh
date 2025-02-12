#!/bin/bash

# Variables
$WP_DIR="/var/www/html"
$DB_NAME="wordpress"
$DB_USER="wordpress"
$DB_PASSWORD="admin123"
$DB_HOST="10.209.133.89"

# Actualizar el sistema e instalar las dependencias necesarias
sudo apt update
sudo apt upgrade -y
sudo apt install -y apache2 php php-mysql wget unzip

# Descargar y configurar WordPress
wget https://wordpress.org/latest.zip -P /tmp
unzip /tmp/latest.zip -d /tmp
sudo mv /tmp/wordpress $WP_DIR

# Configurar permisos
sudo chown -R www-data:www-data $WP_DIR
sudo chmod -R 755 $WP_DIR

# Configurar el archivo wp-config.php
cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php
sed -i "s/wordpress/$DB_NAME/" $WP_DIR/wp-config.php
sed -i "s/wordpress/$DB_USER/" $WP_DIR/wp-config.php
sed -i "s/admin123/$DB_PASSWORD/" $WP_DIR/wp-config.php
sed -i "s/localhost/$DB_HOST/" $WP_DIR/wp-config.php

# Reiniciar Apache
sudo systemctl restart apache2
