#!/bin/bash
# Actualizar la lista de paquetes e instalar PostgreSQL
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

# Crear una base de datos y un usuario con privilegios
sudo -i -u postgres psql -c "CREATE USER ejabberd WITH PASSWORD 'admin123';"
sudo -i -u postgres psql -c "CREATE DATABASE ejjaberd_db OWNER ejabberd;"
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE ejjaberd_db TO ejabberd;"

# Habilitar la autenticación md5 para el acceso remoto (opcional)
sudo bash -c 'echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/$(ls /etc/postgresql)/main/pg_hba.conf'

# Permitir conexiones remotas en postgresql.conf
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/$(ls /etc/postgresql)/main/postgresql.conf

# Reiniciar el servicio de PostgreSQL para aplicar la configuración
sudo systemctl restart postgresql
sudo systemctl enable postgresql