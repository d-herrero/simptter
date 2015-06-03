define simptter::base {
  package { 'build-essential':
    ensure => 'present',
    require => Exec['apt_update']
  }

  package { 'libsqlite3-dev':
    ensure => 'present',
    require => Exec['apt_update']
  }

  package { 'libssl-dev':
    ensure => 'present',
    require => Exec['apt_update']
  }

  package { 'libpq-dev':
    ensure => 'present',
    require => Exec['apt_update']
  }

  package { 'ntp':
    ensure => 'present',
    require => Exec['apt_update']
  }

  include locale
}