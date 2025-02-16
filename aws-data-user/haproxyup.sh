#!/bin/bash

# Actualizar el sistema e instalar HAProxy
sudo apt update
sudo apt install -y haproxy

# Configuración básica de HAProxy (no va a iniciar porque hay que cambiarla según el servicio)
sudo bash -c 'cat > /etc/haproxy/haproxy.cfg <<EOF
defaults
  mode http
  timeout client 10s
  timeout connect 5s
  timeout server 10s
  timeout http-request 10s

frontend myfrontend
  mode http
  bind :80
  default_backend wordpress

backend wordpress
  mode http
  balance roundrobin
  server server1 127.0.0.1:80

EOF'

# Reiniciar HAProxy para aplicar la configuración
sudo systemctl restart haproxy

# Verificar el estado de HAProxy
sudo systemctl status haproxy