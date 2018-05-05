# Daten Validierung


NGINX Modul:

Class Definition

    # modules/nginx/manifests/init.pp
    class nginx (
      String[1] $docroot = '/var/www',
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
      validate_absolute_path($docroot)
      
      package { 'nginx':
        ensure => present,
        name   => $pkgname:
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
      service { 'nginx':
        ensure => running,
        enable => true,
        name   => $svcname:
      }
    }

VHost Define:

    # modules/nginx/manifests/vhost.pp
    define nginx::vhost (
      Stdlib::Absolutepath $docroot = "${nginx::docroot}/vhost",
      Integer[1,1024]      $port    = 80,
    ){
      validate_absolute_path($docroot)
      validate_integer($port)
      
      file { "/etc/ngonx/conf.d/${name}.conf":
        ensure  => file,
        content => template('nginx/vhost.erb'),
        notify  => Service['nginx'],
      }
      file { $docroot:
        ensure  => directory,
      }
      file { "${docroot}/index.html"
        ensure  => file,
        content => template('nginx/index.html.erb'),
      }
    }

Klassen Deklaration

    # modules/nginx/examples/demo.pp
    include nginx

Anwenden des Moduls:

    puppet apply --modulepath ./modules modules/nginx/examples/demo.pp

