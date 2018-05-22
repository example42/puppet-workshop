# Unit testing

Bei Unit Tests wird für eine Klasse/Define/Host ein Catalog in einer Sandbox compiliert. Anschliessend wird der Catalog geparst.

1. PDK
2. selber bauen

PDK ist einfacher, kann aber nur Unit Tests, keine weiteren Tests

Wenn man es selber macht:

## Ruby

Es muss die passende Ruby Version installiert sein.
Entweder System (wird nicht geraten) oder im User Space (besser)
Für User Space gitb es RVM und RBENV.
Beide laden das zu installierende Ruby aus dem Internet und legen es im Homeverzeichnis des Users ab.
Kein Root notwendig!

Weiter Informationen im Example42 Blog post: https://www.example42.com/2017/06/26/psick-developer-environment-setup/

## zusätzliche Dateien:

### Gemfile

Hier werden die notwendigen Ruby Erweiterungen hinterlegt.

    # Gemfile
    gem 'rake'
    gem 'puppet', ENV['PUPPET_VERSION'] || '5.5.0'
    gem 'rspec-puppet'
    gem 'rspec-puppet-utils'
    gem 'puppetlabs_spec_helper'
    gem 'rspec-puppet-facts'
    gem 'r10k'
    gem 'hiera-eyaml'
    gem 'hash-deep-merge'
    gem 'ra10ke'
    gem 'puppet-lint'
    
    # Lint Erweiterungen:
    gem 'puppet-lint-classes_and_types_beginning_with_digits-check'
    gem 'puppet-lint-empty_string-check'
    gem 'puppet-lint-file_ensure-check'
    gem 'puppet-lint-leading_zero-check'
    gem 'puppet-lint-numericvariable'
    gem 'puppet-lint-resource_reference_syntax'
    gem 'puppet-lint-spaceship_operator_without_tag-check'
    gem 'puppet-lint-trailing_comma-check'
    gem 'puppet-lint-undef_in_function-check'
    gem 'puppet-lint-unquoted_string-check'
    gem 'puppet-lint-variable_contains_upcase'
    gem 'puppet-lint-version_comparison-check'

### Rakefile

Hier werden die Rake Tasks hinterlegt:

    require 'rubygems'
    require 'puppetlabs_spec_helper/rake_tasks'
    require 'rspec/core/rake_task'
    require 'puppet'
    require 'ra10ke'
    
    # abort if puppet version is to old
    if Puppet::version < '4'
      puts 'YOU MUST RUN THIS WITH PUPPET 4.x'
      abort
    end
    
    task :default => [:syntax, :lint, :spec]

### spec/spec_helper.rb

Wird vor jedem test ausgewertet:

    require 'puppetlabs_spec_helper/module_spec_helper'
    require 'rake'
    require 'hash_deep_merge'

## Rake Tasks teste

    rake -T

Jetzt können Klassen Tests, Tests für Defines und Host Tests hinterlegt werden.

Siehe http://rspec-puppet.com
