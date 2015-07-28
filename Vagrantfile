# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, path: "bootstrap.sh"
  # rstudio
  config.vm.network "forwarded_port", guest: 8787, host: 8787
  # shiny server
  config.vm.network "forwarded_port", guest: 3838, host: 3838

  # The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder.
  config.vm.synced_folder "datos", "/home/vagrant/datos", create:true
  config.vm.synced_folder "clases", "/home/vagrant/clases", create:true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
    vb.cpus = 2
  end
  
end
