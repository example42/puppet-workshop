
user { 'hpi':
  ensure => present,
}

file { '/etc/hpi':
  ensure => directory,
}

package { 'hpi':
  ensure => present,
}

service { 'hpi':
  ensure => running,
  enable => true,
}


