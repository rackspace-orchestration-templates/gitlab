# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "cookbook-gitlab"
  case 'notcentos'
  when 'centos64'
    config.vm.box = "CentOS-6.4-x86_64-minimal"
    config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box"
  else
    config.vm.box = "opscode-ubuntu-12.04"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  end

  config.vm.network :private_network, ip: "33.33.33.20"
  config.vm.network "forwarded_port", guest: 80, host: 9090
  config.vm.network "forwarded_port", guest: 443, host: 443
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  config.berkshelf.berksfile_path = "./Berksfile"
  config.berkshelf.enabled = true
  config.omnibus.chef_version = "11.6.0"
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug
    chef.json = {
      :deployment => {
        :id => 'eec04ccafe8640d985b28f9c54fcce13'
      },
      :gitlab => {
        :git_branch => 'v6.7.3',
        :admin_password => 'rootroot',
        :admin_user => 'root',
        :database => {
            :password => 'dbpassword'
        },
        :generate_self_signed_cert => true,
        :https => true,
        :self_signed_cert => true
      },
      :mysql => {
        :server_root_password => 'rootpass1',
        :server_debian_password => 'debpass1',
        :server_repl_password => 'replpass1'
      },
    }

    chef.run_list = [
        "recipe[rax-gitlab]",
    ]
  end
end
