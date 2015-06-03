define simptter::db(
  $sql_path = '/srv/puppet/files'
) {
  class { 'postgresql::server':
    listen_addresses => '*',
    ipv4acls => [
      'host all all 10.0.2.0/24 md5',
      'host all all 127.0.0.1/32 md5',
    ],
    require => Exec['apt_update']
  }

  package { 'postgresql-contrib':
    ensure => 'present',
    require => Exec['apt_update']
  }

  postgresql::server::db { 'simptter':
    user => 'daniel',
    password => 'herrero',
    grant => 'all',
    require => Class['postgresql::server']
  }
}