# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
require 'pp'

hosts = YAML.load(File.read("hosts.yaml"))
defaults = YAML.load(File.read("defaults.yaml"))
Vagrant.configure("2") do |config|
  hosts.each do |name, host|
    host = defaults.merge(host)
    config.ssh.forward_agent = true

    config.vm.define name do |host_config|
      host_config.vm.guest = :ubuntu
      host_config.vm.box = 'ubuntu/trusty64'
      host_config.vm.hostname = "#{name}.internal"
      host_config.vm.network :private_network, ip: host[:ip]

#      host_config.vm.synced_folder '.', '/usr/lib/vagrant'

      host_config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id,
                      "--name", name,
                      "--memory", host[:memory],
                      "--cpus", host[:cpu]]
      end

      # start bash as a non-login shell to prevent 'stdin: is not a tty' error
      config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      config.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "#{name}.pp"
        puppet.module_path = ['modules']
        puppet.options = "--verbose"
      end
      if (defined?(host[:forward_from])).nil?
        config.vm.network "forwarded_port", guest: host[:forward_from], host: host[:forward_to]
      end
    end
  end
end
