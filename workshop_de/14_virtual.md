# Virtuelle Resourcen

User Klasse:

    # modules/users/manifests/init.pp
    class users {
      @user { 'martin':
        ensure => present,
        groups => [
          'sysadmin',
          'webadmin'
        ],
      }
      @user { 'bob':
        ensure => present,
        groups => [
          'sysadmin',
          'dbadmin'
        ],
      }
      @user { 'martin':
        ensure => present,
        groups => [
          'netadmin',
          'webadmin'
        ],
      }
    }

Server Klassen:

    # modules/webserver/manifests/init.pp
    class webserver {
      include users
      User <| groups = 'webadmin' |>
    }

    # modules/dbserver/manifests/init.pp
    class dbserver {
      include users
      User <| groups = 'dbadmin' |>
    }

    # modules/nfsserver/manifests/init.pp
    class webserver {
      include users
      User <||>
    }
