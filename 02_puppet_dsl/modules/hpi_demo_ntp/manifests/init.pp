
class hpi_demo_ntp (
  Array   $ntpservers     = ['pool.ntp.org'],
  Boolean $manage_package = true,
  Boolean $manage_service = true,
){
  $ensure_package = $manage_package ? {
    false   => undef,
    default => 'present',
  }
  package { 'ntp':
    ensure => $manage_package,
  }
  file { '/etc/ntp.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => epp('hpi_demo_ntp/ntp.conf.epp', { ntpservers => $ntpservers}),
  }
  service { 'ntpd':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/ntp.conf'],
  }
}


