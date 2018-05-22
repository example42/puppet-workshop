# Acceptance testing

Bei Acceptance Tests wird der Puppet Code auf einem System applied.

Beim ersten Lauf werden Änderungen und keine Fehler erwartet.
Beim zweiten Lauf wirde kein Fehler und keine Änderungen erwartet.

Anschlißend wird das so eingerichtete System mit Hilfe von Serverspec analysiert.

## Notwendige Dateien

### Gemfile

Hier wird folgende zusätzlich benötigt:

    gem 'beaker'
    gem 'beaker-rspec'
    gem 'beaker-puppet_install_helper'

### spec/spec_helper_acceptance.rb

Hier wird hinterlegt, was vor einen Test auf dem System vorbereitet werden muss.

z.B.

    require 'beaker-rspec'
    require 'beaker/puppet_install_helper'
    begin
      require 'puppet'
    rescue TypeError
    end
    
    run_puppet_install_helper()

### spec/acceptance/nodesets/default.yaml

Config file für Beaker, in der das System hinterlegt wird:

    HOSTS:
      centos7-box:
        platform: el-7-x86_64
        hypervisor: docker
        image: centos7-systemd
        docker_cmd: '["/usr/sbin/init"]'

        mount_folders:
          controlrepo:
            host_path: .
            container_path: /puppet_code

        docker_preserve_image: false
        docker_image_commands:
          - 'rm -f /etc/puppetlabs/puppet/hiera.yaml'

    CONFIG:
      type: foss

### spec/acceptance/test_spec.rb

Hier wird der test für eine Klasse/Modul hinterlegt:

    require 'spec_helper_acceptance'

    describe 'java_system' do
      let(:manifest) {
        <<-EOS
          include role::java_system
        EOS
      }
      it 'should run without errors' do
        result = apply_manifest(manifest, :catch_failures => true)
        expect(@result.exit_code).to eq 2
      end
      it 'should run a second time without changes' do
        result = apply_manifest(manifest, :catch_changes => true)
        expect(@result.exit_code).to eq 0
      end
      
      # serverspec:
      describe package('java') do
        it { should be_installed }
      end

    end
