# Puppet Server Tuning

## JVM Heap

Je nach OS

- /etc/sysconfig/puppetserver
- /etc/default/puppetserver

JAVA_OPTS='-Xmx4G ...'

## max-active-instances

`/etc/puppetlabs/puppetserver/conf.d/puppetserver.conf`

Die Einstellung muss mit JVM Heap synchronisiert werden.

Ratschlag: `512MB + (max-active-instances * 512MB)`

## Code cache


`/etc/puppetlabs/puppetserver/conf.d/puppetserver.conf`

`environment-class-cache-enabled: true`

Aber: dann muss Cache Invalidierung für Code Deployment genutzt werden.

Besser:

`environment.conf` cache_timeout setzen

## Metrics

Export zu Graphite

Grafana zur Visualisierung.

https://puppet.com/docs/puppetserver/5.3/puppet_server_metrics.html

