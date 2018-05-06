# Hiera

SSH Modul

    # modules/ssh/manifests/init.pp
    class ssh (
      Enum['yes', 'no', 'permit_password'] $allow_root = 'no',
    ){
      package { 'openssh':
        ensure => present,
      }
      file { '/etc/ssh/sshd_config':
        ensure  => file,
        content => epp('ssh/sshd_config.epp'),
      }
      service { 'sshd':
        ensure => running,
        enable => true,
      }
      
      Package['openssh']
      -> File['/etc/ssh/sshd_config']
      ~> Service['sshd']
    }

Hiera config file

    # /etc/puppetlabs/puppet/hiera.yaml # Hiera 3
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
    ssh::allow_root: 'no'

    # /etc/puppetlabs/code/hieradata/location/berlin.yaml
    ssh::allow_root: 'yes'

    # /etc/puppetlabs/code/hieradata/host/jenkins.berlin.domain.com.yaml
    ssh::allow_root: 'permit_password'

Deklaration

    # modules/ssh/examples/ssh_class.pp
    include ssh
    # class { 'ssh':
    #   allow_root => 'yes',
    # }
