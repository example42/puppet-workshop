# Concat

Agent:

    # modules/monitoring/manifests/agent.pp
    class monitoring::agent {
      @@concat::fragment { "monitoring ${::fqdn}":
        target  => '/etc/monitoring/serverlist.txt'
        content => "${::fqdn} - ${::domain} - ${::kernel}\n",
        order   => '50',
        tag     => [
          $::environment,
        ],
      }
    }

Server:

    # modules/monitoring/manifests/server.pp
    class monitoring::server {
      concat { '/etc/monitoring/serverlist.txt':
        ensure => present,
      }
      Concat::Fragment <<| tag == 'production' |>>
    }
