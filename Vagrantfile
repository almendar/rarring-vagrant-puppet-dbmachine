# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "raring64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.network :bridged
  config.vm.host_name = "dbMachine"
  # config.vm.boot_mode = :gui

  config.vm.forward_port 27017, 27017
  config.vm.forward_port 28017, 28017
  config.vm.forward_port 8091, 8091
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"
    puppet.module_path = "modules"
    puppet.options = "--verbose --debug"
  end
end
