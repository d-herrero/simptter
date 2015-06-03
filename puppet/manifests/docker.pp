simptter::apt { 'simptter': }

simptter::base { 'simptter': }

simptter::db { 'simptter':
  sql_path => '/srv/simptter/puppet/files'
}

simptter::simptter { 'simptter':
  dev_stuff => false,
  simptter_path => '/srv/simptter'
}