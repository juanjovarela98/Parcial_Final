#!/bin/bash
echo "Aprovisionamiento...."
echo "Comenzando la configuración!!"
sudo -i
echo "Instalando herramientas"
sudo yum -y install vim net-tools

echo "Configurando el redireccionamiento...."
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

echo "Inciando servicio de firewall..."
sudo service firewalld start
sudo chkconfig firewalld on

echo "configurando interfaz interna y reglas para eth1"
sudo firewall-cmd --permanent --zone=internal --add-interface=eth1
sudo firewall-cmd --permanent --zone=internal --add-service=http 
sudo firewall-cmd --permanent --zone=internal --add-port=80/tcp 
sudo firewall-cmd --permanent --zone=internal --add-port=8080/tcp 
sudo firewall-cmd --permanent --zone=internal --add-masquerade
sudo firewall-cmd --permanent --zone=internal --add-forward-port=port=80:proto=tcp:toport=8080:toaddr=192.168.50.4
sudo firewall-cmd --permanent --zone=internal --add-forward-port=port=8080:proto=tcp:toport=8080:toaddr=192.168.50.4

echo "configurando interfaz publica y reglas para eth2"
sudo firewall-cmd --permanent --zone=public --add-interface=eth2

sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp 
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp 
sudo firewall-cmd --permanent --zone=public --add-masquerade 
sudo firewall-cmd --permanent --zone=public --add-forward-port=port=80:proto=tcp:toport=8080:toaddr=192.168.50.4
sudo firewall-cmd --permanent --zone=public --add-forward-port=port=8080:proto=tcp:toport=8080:toaddr=192.168.50.4
sudo firewall-cmd --reload
echo "¡¡Configuraciones realizadas con exito!!"