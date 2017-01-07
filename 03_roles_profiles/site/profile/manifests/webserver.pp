
class profile::webserver {
  class { 'apache':
    default_mods => false,
  }
  class { 'apache::mod::rewrite': }
  class { 'apache::mod::ssl': }
  class { 'apache::mod::php': }
  contain php
}


