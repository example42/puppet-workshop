
class role::app_server {
  contain profile::webserver
  contain profile::backup
  contain profile::monitoring
}


