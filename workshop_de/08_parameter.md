# Parameter



NGINX Modul:

Class Definition

    # modules/nginx/manifests/init.pp
    class nginx (
      $docroot = '/var/www',
    ){
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
      file { $docroot:
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

1. ohne Parameter:

    # modules/nginx/examples/demo.pp
    include nginx
    # oder
    class { 'nginx': }

2. mit Parameter:

    # module/nginx/examples/demo_with_parameter.pp
    class { 'nginx':
      docroot => '/opt/www',
    }

Anwenden des Moduls:

    puppet apply --modulepath ./modules modules/nginx/examples/demo.pp

