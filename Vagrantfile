# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # box config
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.customize [
                      "modifyvm", :id,
                      "--name", "Test_Environment",
                      "--memory", "1024"
                    ]
  end

  # network config
  # config.vm.network :forwarded_port, guest: 80, host: 8080
  # config.vm.network :private_network, ip: "192.168.33.10"
  # config.vm.network :public_network
  config.vm.network :forwarded_port, guest: 8080, host: 8080 # NginX Proxy
  config.vm.network :forwarded_port, guest: 8090, host: 8090 # Apache+PHP
  config.vm.network :forwarded_port, guest: 4000, host: 4000 # Phoenix

  # provision config
  config.vm.provision "shell", path: "bootstrap.sh"
  
end