define simptter::apt {
  class { 'apt':
    always_apt_update => true
  }

  apt::key { 'altenwald':
    ensure => 'present',
    key => 'E552FAF7',
    key_source => 'http://apt.bosqueviejo.net/altenwald.key'
  }

  apt::source { 'altenwald':
    location => 'http://apt.bosqueviejo.net',
    release => 'wheezy',
    repos => 'contrib',
    include_src => true,
    require => [
      Apt::Key['altenwald'],
    ]
  }
}