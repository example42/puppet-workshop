# Node Klassifizierung

Puppet Master:

    # /etc/puppetlabs/code/environments/production/manifests/site.pp
    node 'your node certname' {
      include nginx
    }

Agent:

    puppet agent --test

Zertifikate:

Puppet Master:

    puppet cert list --all
    puppet cert print <certname>
