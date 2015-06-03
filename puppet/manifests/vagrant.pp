simptter::apt { 'simptter': }

simptter::base { 'simptter': }

simptter::db { 'simptter':
  sql_path => '/vagrant/puppet/files'
}

simptter::simptter { 'simptter':
  dev_stuff => true,
  simptter_path => '/vagrant'
}