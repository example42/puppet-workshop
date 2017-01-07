
class profile::dbserver {
  $ysql_root_pw = hiera('infrastructure::mysql_root_pw', '')
  class { 'mysql::server':
    root_password => $mysql_root_pw,
  }
  class { 'mysql::bindings::php': }
}


