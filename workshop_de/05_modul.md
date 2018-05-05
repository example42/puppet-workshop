# Modul


Modul Struktur:

    <environmentpath>/<modulepath>/
      <modulename>/
        |- manifests/
        |    |- init.pp
        |    \- subclass.pp
        |- files/
        |    \- static_config_file
        |- templates/
        |    \- dynamic_config_file(.erb|.epp)
        |- lib/
        |    |- facter/
        |    \- puppet/
        \- examples/
             \- demo_usage.pp

NGINX Modul:

Class Definition

    # modules/nginx/manifests/init.pp
    class nginx {
      package { 'nginx':
        ensure => present,
      }
      file { '/var/www':
        ensure => directory,
      }
      service { 'nginx':
        ensure => running,
        enable => true,
      }
    }

Klassen Deklaration

    # modules/nginx/examples/demo.pp
    include nginx

Anwenden des Moduls:

    puppet apply --modulepath ./modules modules/nginx/examples/demo.pp

