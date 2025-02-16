#!/bin/bash

# Establecer el nombre del host
hostnamectl set-hostname agarciaaproxyaz2.duckdns.org

# Actualizar la lista de paquetes disponibles
apt-get update

# Descargar el paquete ejabberd
wget https://github.com/processone/ejabberd/releases/download/23-01/ejabberd_23.01-1_amd64.deb

# Instalar el paquete ejabberd
dpkg -i ejabberd_23.01-1_amd64.deb