# Templates


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
        ensure  => file,
        content => template('nginx/ngonx.conf.erb'),
        # content => epp('nginx/ngonx.conf.epp'), # Puppet 4
        notify  => Service['nginx'],
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

