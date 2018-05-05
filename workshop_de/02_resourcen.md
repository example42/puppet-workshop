# Resource Anwendung

Resourcen finden;

    puppet describe --list

Resourcen Dokumentation

    puppet describe user

Resourcen Deklaration:

    # /root/manifest.pp
    user { 'martin':
      ensure => present,
      gid    => 'martin',
    }
    group { 'martin':
      ensure => present,
    }
    file { '/home/martin':
      ensure => directory,
      owner  => 'martin',
      group  => 'martin',
      mode   => '0755',
    }

Puppet apply

    puppet apply /root/manifest.pp

