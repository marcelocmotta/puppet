# coding: utf-8
# Arquivo template de configuracao
# do vagrant para teste de modulos do puppet.
# Autor: leonardo.rmello@dataprev.gov.br
#
# CONFIGURACAO DE VARIAVEIS
# Domínio dos servidores
DOMAIN="mte.prevnet"

# Normalmente esta memória é mais do que suficiente.
MEMORY=1024

#if !Vagrant.has_plugin?("vagrant-proxyconf")
#        system('vagrant plugin install vagrant-proxyconf')

#     raise("vagrant-proxyconf installed. Run command again.");
#end


Vagrant.configure("2") do |config|
#  if Vagrant.has_plugin?("vagrant-proxyconf")
#    config.proxy.http     = "http://10.122.9.217:8081/"
#    config.proxy.https    = "http://10.122.9.217:8081/"
#    config.proxy.no_proxy = "nuvemdtp configdtp prevnet"
#  end

  config.ssh.password = "vagrant"
  config.ssh.insert_key = true
  config.vm.provision "shell",
     run: "always",
     inline: "mkdir -p /etc/facter/facts.d/"
#   config.vm.provision "shell",
#      run: "always",
#      inline: "setenforce 0"
   # config.vm.provision "shell",
   #    run: "always",
   #    inline: "route add default gw 192.168.0.1"
#   config.vm.provision "shell",
#      run: "always",
#     inline: "systemctl stop firewalld"

     config.vm.define "rhel-65" do |v|
       v.vm.box = "redhat-65-puppet5"
       v.vm.box_url = '/home/marcelo.cmotta/boxes/rhel-65-puppet5.box'
       v.vm.host_name = "rhel65.#{DOMAIN}"
    #  v.vm.network "private_network", ip: "192.168.0.03" #, gw: "192.168.0.1" , subnet: "255.255.255.0" #auto_config: "false"
       v.vm.provider "virtualbox" do |virtualbox|
         virtualbox.name = "rhel-65"
         virtualbox.memory = MEMORY
         virtualbox.cpus = 1

       end
       # Configura o puppet como provider
       v.vm.provision :puppet, :options => ["--pluginsync"], :module_path => "deploy/modules" do |puppet|
         puppet.manifests_path = "deploy"
         puppet.manifest_file = "site.pp"
         puppet.options = "--verbose"
         puppet.hiera_config_path = "hiera.yaml"
       end
     end

     config.vm.define "rhel-74" do |v|
       v.vm.box = "redhat-74-puppet5"
       v.vm.box_url = '/home/marcelo.cmotta/boxes/rhel-74-puppet5.box'
       v.vm.host_name = "rhel-74.#{DOMAIN}"
       v.vm.network "private_network", ip: "192.168.0.10" #, gw: "192.168.0.1" , subnet: "255.255.255.0" #auto_config: "false"
       v.vm.provider "virtualbox" do |virtualbox|
         virtualbox.name = "rhel-74"
         virtualbox.memory = MEMORY
         virtualbox.cpus = 1

       end
       # Configura o puppet como provider
       v.vm.provision :puppet, :options => ["--pluginsync"], :module_path => "deploy/modules" do |puppet|
         puppet.manifests_path = "deploy"
         puppet.manifest_file = "site.pp"
         puppet.options = "--verbose"
         puppet.hiera_config_path = "hiera.yaml"
       end
     end

     config.vm.define "rhel-81" do |v|
       v.vm.box = "redhat-81-puppet5"
       v.vm.box_url = 'F:\vagrant_boxes_puppet5\rhel-81-puppet5.box'
       v.vm.host_name = "rhel-81.#{DOMAIN}"
       v.vm.network "private_network", ip: "192.168.0.80" #, gw: "192.168.0.1" , subnet: "255.255.255.0" #auto_config: "false"
       v.vm.provider "virtualbox" do |virtualbox|
         virtualbox.name = "rhel-81"
         virtualbox.memory = MEMORY
         virtualbox.cpus = 1

       end
       # Configura o puppet como provider
       v.vm.provision :puppet, :options => ["--pluginsync"], :module_path => "deploy/modules" do |puppet|
         puppet.manifests_path = "deploy"
         puppet.manifest_file = "site.pp"
         puppet.options = "--verbose"
         puppet.hiera_config_path = "hiera.yaml"
       end
     end

     config.vm.define "debian-7" do |v|
       v.vm.box = "debian-7-puppet5"
       v.vm.box_url = '/home/marcelo.cmotta/boxes/debian-7-puppet5.box'
       v.vm.host_name = "debian7.#{DOMAIN}"
    #   v.vm.network "private_network", ip: "192.168.0.05" #, gw: "192.168.0.1" , subnet: "255.255.255.0" #auto_config: "false"
       v.vm.provider "virtualbox" do |virtualbox|
         virtualbox.name = "debian-7"
         virtualbox.memory = MEMORY
         virtualbox.cpus = 1

       end
       # Configura o puppet como provider
       v.vm.provision :puppet, :options => ["--pluginsync"], :module_path => "deploy/modules" do |puppet|
         puppet.manifests_path = "deploy"
         puppet.manifest_file = "site.pp"
         puppet.options = "--verbose"
         puppet.hiera_config_path = "hiera.yaml"
       end
     end
end
