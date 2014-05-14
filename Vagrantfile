# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.hostname = "logstash-forwarder-berkshelf"

  config.vm.box = "precise64"

  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network :private_network, ip: "33.33.33.99"

  config.vm.provision :shell, :inline => 'apt-get update'
  config.vm.provision :shell, :inline => 'apt-get install -y build-essential ruby1.9.1-dev --no-upgrade'
  config.vm.provision :shell, :inline => "gem install chef --version 11.10.4 --no-rdoc --no-ri --conservative"

  config.vm.provision :chef_solo do |chef|
    chef.log_level = :info

    chef.cookbooks_path = "../"

    chef.json = {}

    chef.run_list = [
        "recipe[logstash-forwarder::default]"
    ]
  end
end
