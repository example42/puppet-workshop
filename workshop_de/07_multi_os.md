# Mehrere Betriebssysteme



NGINX Modul:

Class Definition

    # modules/nginx/manifests/init.pp
    class nginx {
      case $::osfamily {
        'RedHat': {
          $pkgname = 'nginx'
          $cfgfile = '/etc/nginx.conf'
          $runuser = 'apache'
          $svcname = 'nginx'
        }
        'SUSE': {
          $pkgname = 'nginx'
          $cfgfile = '/etc/nginx.conf'
          $runuser = 'apache'
          $svcname = 'nginx'
        }
        default: {
          fail('OS not supported.')
        }
      }
      package { $pkgname:
        ensure => present,
      }
      file { '/var/www':
        ensure => directory,
      }
      file { $cfgfile:
        ensure => file,
        source => 'puppet:///modules/nginx/nginx.conf',
        notify => Service['nginx'],
      }
      service { $svcname:
        ensure => running,
        enable => true,
      }
    }

Klassen Deklaration

    # modules/nginx/examples/demo.pp
    include nginx

Anwenden des Moduls:

    puppet apply --modulepath ./modules modules/nginx/examples/demo.pp

