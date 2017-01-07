
class profile::ntp_config {
  if $::certname == 'ntp1.domain.com' {
    $ntpservers = ['localhost']
  } else {
    if $::environment == 'production' {
      $ntpservers = ['ntp1.domain.com']
    } else {
      # internal NTP is broken
      # please switch when system is functional again
      $ntpservers = ['pool.ntp.org']
    }
  }
  class { 'hpi_demo_ntp':
    ntpservers => $ntpservers,
  }
}


class profile::ntp_config {
  $ntpservers = hiera('ntpservers')
  class { 'hpi_demo_ntp':
    ntpservers => $ntpservers,
  }
}

class profile::ntp_config {
  # $ntpservers = hiera('hpi_demo_ntp::ntpservers')
  include hpi_demo_ntp
}



