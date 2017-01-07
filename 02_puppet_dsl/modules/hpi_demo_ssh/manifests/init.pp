
class hpi_demo_ssh (
  Boolean $server     = true,
  Boolean $client     = true,
  Boolean $allow_root = false,
) {
  if $server {
    include hpi_demo_ssh::server
  }
  if $client {
    include hpi_demo_ssh::client
  }
}


