# Install Puppet + Resource Abfragen

    git clone https://github.com/example42/psick.git
    cd psick/vagrant/environments/foss
    vagrant up puppet.foss.psick.io

Einloggen:

    vagrant ssh puppet.foss.psick.io
    sudo -i

Resourcen auslesen:

    puppet resource user root
    puppet resource package puppet-agent
    puppet resource file /etc/motd

Resource mit allen Instanzen auslesen:

    puppet resource group
    puppet resource service

