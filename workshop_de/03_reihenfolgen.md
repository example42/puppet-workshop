# Resource Reihenfolge

Metaparameter:

- require
- before
- subscribe
- notify

Resource Referenz:

    Type['title']

Resourcen Deklaration:

    # /root/manifest.pp
    user { 'martin':
      ensure  => present,
      gid     => 'martin',
      require => Group['martin'],
      before  => File['/hom/martin'],
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

Chaining:

    Group['martin']
    -> User['martin']
    -> File['/home/martin']

Config Datei und Service refresh:

    file { '/etc/ssh/sshd_config':
      ensure => file,
      mode   => '0644',
    }
    service { 'sshd':
      ensure => running,
      enable => true,
      subscribe => File['/etc/ssh/sshd_config',
    }

Chaining:

    File['/etc/ssh/sshd_config']
    ~> Service['sshd']
