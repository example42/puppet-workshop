# Hiera

Hiera config Datei:

1. Hiera config v3 (globale hiera Konfiguration):

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

2. Hiera config v5 (Hiera Konfiguration pro Environment)

    # control-repo/hiera.yaml
    ---
    version: 5

    defaults:
      datadir: data
      data_hash: yaml_data

    hierarchy:
      - name: "hierarchies"
        paths:
          - "hosts/%{trusted.certname}.yaml"
          - "location/%{facts.datacenter}.yaml"
          - "common.yaml"

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

