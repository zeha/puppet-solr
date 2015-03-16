#include solr
file {'/tmp/schema.xml':
  ensure  => file,
  content => inline_template('test info'),
}

class {'solr':
  url     => 'http://repository.test.zen.landcareresearch.co.nz/download/solr/',
  version => '4.10.3',
  require => File['/tmp/schema.xml']
}


solr::core{'test':
  schema_src_file => '/tmp/schema.xml',
  require         => Class['solr'],
}

solr::core{'test2':
  schema_src_file => '/tmp/schema.xml',
  require         => Class['solr'],
}