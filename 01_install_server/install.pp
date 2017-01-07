class ex42_workshop_puppetserver {
  yumrepo { 'puppetlabs':
  }

  package { 'puppetserver':
    ensure => present,
  }

}
