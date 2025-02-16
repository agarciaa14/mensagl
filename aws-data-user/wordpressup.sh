#!/bin/bash

# Variables
WP_DIR="/var/www/html"
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="admin123"
DB_HOST="10.209.134.31"

# Actualizar el sistema e instalar las dependencias necesarias
sudo apt update
sudo apt upgrade -y
sudo apt install -y apache2 php php-mysql wget unzip

# Descargar y configurar WordPress
wget https://wordpress.org/latest.zip -P /tmp
unzip /tmp/latest.zip -d /tmp

# Verificar si la descarga y la extracción fueron exitosas
if [ ! -d "/tmp/wordpress" ]; then
    echo "Error: La descarga y extracción de WordPress han fallado."
    exit 1
fi

# Eliminar el directorio existente si no está vacío
if [ "$(ls -A $WP_DIR)" ]; then
    sudo rm -rf $WP_DIR/*
fi

sudo mv /tmp/wordpress/* $WP_DIR

# Configurar permisos
sudo chown -R www-data:www-data $WP_DIR
sudo chmod -R 755 $WP_DIR

# Verificar la existencia de wp-config-sample.php antes de copiar
if [ -f "$WP_DIR/wp-config-sample.php" ]; then
    sudo cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php
else
    echo "Error: No se encontró wp-config-sample.php en $WP_DIR."
    exit 1
fi

# Configurar el archivo wp-config.php
sudo sed -i "s/database_name_here/$DB_NAME/" $WP_DIR/wp-config.php
sudo sed -i "s/username_here/$DB_USER/" $WP_DIR/wp-config.php
sudo sed -i "s/password_here/$DB_PASSWORD/" $WP_DIR/wp-config.php
sudo sed -i "s/localhost/$DB_HOST/" $WP_DIR/wp-config.php

# Verificar que el archivo wp-config.php se haya configurado correctamente
if [ ! -f "$WP_DIR/wp-config.php" ]; then
    echo "Error: No se pudo configurar wp-config.php."
    exit 1
fi

# Reiniciar Apache
sudo systemctl restart apache2
