# Modul und Parametrisierte Klasse

SSH Modul

    # modules/ssh/manifests/init.pp
    class ssh (
      Enum['yes', 'no', 'permit_password'] $allow_root = 'no',
    ){
      package { 'openssh':
        ensure => present,
      }
      file { '/etc/ssh/sshd_config':
        ensure  => file,
        content => epp('ssh/sshd_config.epp'),
      }
      service { 'sshd':
        ensure => running,
        enable => true,
      }
      
      Package['openssh']
      -> File['/etc/ssh/sshd_config']
      ~> Service['sshd']
    }

SSHD Config File Template

    # modules/ssh/templates/sshd_config.epp
    Port 22
    PermitRootLogin <%= $ssh::allow_root %>
    # ...

Deklaration

    # modules/ssh/examples/ssh_class.pp
    include ssh
    # class { 'ssh':
    #   allow_root => 'yes',
    # }
