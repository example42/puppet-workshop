# Control Repository

Inhalt:

- Puppetfile (referenziert Upstream Module)
- environment.conf (Konfiguriert modulepath, config_version und cache timeout)
- hiera.yaml (Hiera config v5)
- manifests/site.pp (Node Klassifizierung)
- site/profile (Profile Modul)
- site/role (Rollen Modul)
- data (Hieradaten)

Ein GIT Repository. Default Branch ist `production`.
Jeder Branch wird zu einem Puppet Environment.

Nur ein langlebiger Branch (Production).

Deployment mit Hilfe von r10k:

    #/etc/puppetlabs/r10k/r10k.yaml
    ---
    cachedir: '/var/cache/r10k'
    sources:
      puppet:
       remote: 'git@gitserver:puppet-control-repo.git'
    git: 'shellgit'
    forge:
      baseurl: 'https://forgemirror.example.com'

Upstrema Module entweder im GIT Server, oder auf einem (lokalen) Forge Server

Deployment:

    r10k deploy environment -pv
