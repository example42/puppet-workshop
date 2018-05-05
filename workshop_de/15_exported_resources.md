# Exportierte Resourcen

Puppet DB:

    # modules/puppetdb/manifests/init.pp
    class puppetdb {
      package { 'puppetdb':
        ensure => present,
      }
      file { '/etc/puppetlabs/puppet/puppetdb.conf':
        ensure => file,
        source => 'puppet:///modules/puppetdb/puppetdb.conf',
      }
      file { '/etc/puppetlabs/puppet/routes.yaml':
        ensure => file,
        source => 'puppet:///modules/puppetdb/routes.yaml',
      }
      service { 'puppetdb':
        ensure => running,
        enable => true,
      }
      exec { 'restart puppet master':
        command     => 'service puppetserver restart',
        refreshonly => true,
        subscribe   => [
          File['/etc/puppetlabs/puppet/puppetdb.conf'],
          File['/etc/puppetlabs/puppet/routes.yaml'],
        ],
      }
    }

Host Klasse:

    # modules/hosts/manifests/init.pp
    class hosts {
      host { 'localhost':
        ensure => present,
        ip     => '127.0.0.1',
      }
      @@host { $::fqdn:
        ensure => present,
        ip     => $::ipaddress,
      }
      Host <<| |>>
    }
    