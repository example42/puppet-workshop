# Hiera

Hiera config Datei:

    # /etc/puppetlabs/puppet/hiera.yaml
    ---
    :backends:
      - yaml
    :hierarchy:
      - "host/%{::fqdn}"
      - "location/%{::datacenter}
      - common
    :yaml:
      :datadir: "/etc/puppetlabs/code/hieradata"

Hiera Daten:

    # /etc/puppetlabs/code/hieradata/common.yaml
    ntpservers:
      - '8.8.8.8'
      - '4.4.4.4'
    
    # /etc/puppetlabs/code/hieradata/location/berlin.yaml
    ntpservers:
      - 'ntp.berlin.domain.com'
    
    # /etc/puppetlabs/code/hieradata/host/ntp.berlin.domain.com.yaml
    ntpservers:
      - 'pool.ntp.org'

Lookup:

Hiera 3:

    hiera -c /etc/puppetlabs/puppet/hiera.yaml <key> [<fact var name> = <value>] [-d]

Hiera 5:

    puppet lookup --node <certname> <key>

