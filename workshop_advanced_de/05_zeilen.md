# Einzelne Zeilen

Ini Setting:


    # modules/puppetagent/manifests/init.pp
    class puppetagernt {
      ini_setting { 'puppet agent environment':
        ensure  => present,
        path    => '/etc/puppetlabs/puppet/puppet.conf'
        section => 'agent',
        setting => 'environment',
        value   => 'production',
      }
    }

File Line

    # modules/user_profiles/manifests/proxy.pp
    define user_profiles::proxy {
      file_line { "${title} bashrc proxy":
        ensure => present,
        path   => "/home/${title}/.bashrc",
        line   => 'export HTTP_PROXY=http://proxy.domain.tld:3128',
        match  => 'export HTTP_PROXY',
      }
    }

