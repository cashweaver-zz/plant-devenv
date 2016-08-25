# -*- mode: ruby -*-
# vi: set ft=ruby :
# ref: https://github.com/RyanAmos/rethinkdb-vagrant/commit/d34bf5bc0f12190ee85785796f3b88fa9cc3166f

# Ensure a minimum Vagrant version to prevent potential issues.
Vagrant.require_version '>= 1.5.0'

# Configure using Vagrant's version 2 API/syntax.
Vagrant.configure(2) do |config|
  # Ubuntu 14.04, 64 bit
  config.vm.box         = 'ubuntu/trusty64'
  config.vm.box_version = '~> 14.04'

  # Providers
  config.vm.provider :virtualbox do |p|
    p.customize ['modifyvm', :id, '--memory', '512', '--ioapic', 'on']
  end

  # SSH
  config.ssh.username = 'vagrant'

  config.vm.define "api" do |api|
    # Port Forwarding
    config.vm.network :forwarded_port, guest: 3000,  host: 3000

    # Provisioning
    config.vm.provision :shell do |sh|
      sh.inline = <<-EOF
        export DEBIAN_FRONTEND=noninteractive;

        # Install Node.js
        # ref: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
        curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
        apt-get install -y nodejs

        # Install RethinkDB
        # ref: http://www.rethinkdb.com/docs/install/ubuntu/
        source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
        wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
        apt-get update
        apt-get install rethinkdb

        # Install JS drivers for RethinkDB
        # ref: http://www.rethinkdb.com/docs/install-drivers/javascript/
        npm install rethinkdb

      EOF
    end
  end

  #config.vm.define "app" do |app|
  #end
end
