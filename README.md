# Parcial_Final

Desarrollar las siguientes implementaciones. Estas deben ser sustentadas individualmente.

1. [2.0 Puntos (Funcionamiento + Sustentación)] SERVICIO + FIREWALL. Instalar el servidor de
streaming Streama protegido por Firewall como se muestra en la figura. Todas las solicitudes hacia el
servidor Streama deberán ser realizadas al firewall y no directamente al servicio configurado. El firewall
debe redirigir las peticiones al servicio.
Compruebe el funcionamiento desde el navegador del anfitrión y del SmartPhone.
![image](https://user-images.githubusercontent.com/98847734/170098087-d36cbc5b-50a3-434d-96c2-eccb4701b521.png)

2. [1.0 Puntos (Funcionamiento + Sustentación)]] APROVISIONAMIENTO. Utilice los servicios de
aprovisionamiento que provee Vagrant usando Shell para que los servicios del punto anterior (Firewall +
Streama) queden aprovisionados de manera automática.


==VAGRANT File del STREAMA:

Vagrant.configure("2") do |config|
  if Vagrant.has_plugin? "vagrant-vbguest"
    config.vbguest.no_install = true
    config.vbguest.auto_update = false
    config.vbguest.no_remote = true
  end
  config.vm.define :streama do | streama |
    streama.vm.box = "bento/centos-7"
    streama.vm.network :private_network, ip: "192.168.50.4"
    streama.vm.hostname = "streama"
    streama.vm.provision "shell", path: "streamaProvi.sh"
  end
end

==VAGRANT file del FIREWALL:

Vagrant.configure("2") do |config|
	if Vagrant.has_plugin?("vagrant-vbguest")
		config.vbguest.auto_update = false 
	end
	config.vm.define :firewall do | firewall |
		firewall.vm.box = "centos/stream8"
		firewall.vm.network :private_network, ip: "192.168.50.2"
		firewall.vm.network :public_network, ip: "192.168.1.200"
		firewall.vm.network :forwarded_port, guest: 80, host: 9000
		firewall.vm.hostname = "firewall"
		firewall.vm.provision "shell", path: "firewallscript.sh"
	end
end
