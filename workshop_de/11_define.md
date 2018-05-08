# Selbst definierter Resource Typ


NGINX Modul:

Class Definition

    # modules/nginx/manifests/init.pp
    class nginx (
      $docroot = '/var/www',
    ){
      case $::osfamily {
        'RedHat': {
          $pkgname = 'nginx'
          $cfgfile = '/etc/nginx/nginx.conf'
          $runuser = 'apache'
          $svcname = 'nginx'
        }
        'SUSE': {
          $pkgname = 'nginx'
          $cfgfile = '/etc/nginx/nginx.conf'
          $runuser = 'apache'
          $svcname = 'nginx'
        }
        default: {
          fail('OS not supported.')
        }
      }
      package { 'nginx':
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
      $docroot = "${nginx::docroot}/vhost",
      $port    = '80',
    ){
      file { "/etc/nginx/conf.d/${name}.conf":
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
    nginx::vhost { 'foobar.com': }
    nginx::vhost { 'barfoo.com':
      docroot => '/www2',
    }
    nginx::vhost { 'barbar.com':
      port => 81,
    }

Anwenden des Moduls:

    puppet apply --modulepath ./modules modules/nginx/examples/demo.pp

