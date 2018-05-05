# Klassen


Klassen Definition:

    # /root/manifest.pp
    class mein_account {
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

Puppet apply:

    puppet apply /root/manifest.pp

Klassen deklaration:

    include mein_account
