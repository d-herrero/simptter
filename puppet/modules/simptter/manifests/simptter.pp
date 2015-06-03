
define simptter::simptter(
  $dev_stuff = true,
  $simptter_path = '/srv',
) {
  file { '/etc/profile.d/append-ruby-path.sh':
    mode => 644,
    content => 'export PATH=/opt/ruby-2.1/bin:$PATH'
  }

  package { 'ruby-2.1':
    ensure => 'latest',
    require => Apt::Source['altenwald']
  }

  file { '/usr/bin/gem':
    ensure => 'link',
    target => '/opt/ruby-2.1/bin/gem',
    require => Package['ruby-2.1']
  }

  package { 'bundle':
    provider => 'gem',
    ensure => 'present',
    source => 'http://rubygems.org/',
    require => [
      Package['ruby-2.1'],
      File['/usr/bin/gem']
    ]
  }

  exec { 'rails':
    command => 'bundle install',
    path => '/usr/bin:/bin:/opt/ruby-2.1/bin',
    cwd => $simptter_path,
    user => 'vagrant',
    require => Package['bundle']
  }
}