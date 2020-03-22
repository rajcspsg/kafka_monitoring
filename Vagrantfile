# -*- mode: ruby -*-
# vi: set ft=ruby :

builds = {
  'zookeeper.com' => {
    id: "11",
    ip: "192.168.10.25",
    role: "zookeeper",
    memory: "512",
    deployId: "1"
  },
  'kafka1.com' => {
    id: "21",
    ip: "192.168.10.35",
    role: "kafka",
    memory: "512",
    deployId: "1"
  },
  'kafka2.com' => {
    id: "22",
    ip: "192.168.10.36",
    role: "kafka",
    memory: "512",
    deployId: "2"
  },
  'kafka3.com' => {
    id: "23",
    ip: "192.168.10.37",
    role: "kafka",
    memory: "512",
    deployId: "3"
  },
  'kafkamisc.com' => {
    ip: "192.168.10.51",
    role: "kafkamisc",
    memory: "512"
  }
}

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  builds.each_pair do |name, opts|

    config.vm.define name.to_sym do |guest|

      guest.vm.network "private_network", ip: opts[:ip]

      guest.vm.provider "virtualbox" do |vb|
        vb.memory = opts[:memory]
      end

      case opts[:role]
      when "kafka"
        guest.vm.provision :shell, :path => "deployKafka.sh", :args => "#{opts[:deployId]} "
      when "zookeeper"
        guest.vm.provision :shell, :path => "deployZookeeper.sh", :args => "#{opts[:deployId]}"
      when "kafkamisc"
        guest.vm.provision :shell, :path => "deployMisc.sh"
      end

    end
  end
end
