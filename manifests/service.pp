# @summary Manages the service for solr.
#
class solr::service {
  anchor{'solr::service::begin':}

  service { 'solr':
    ensure  => running,
    enable  => true,
    require => Anchor['solr::service::begin'],
  }

  anchor{'solr::service::end':
    require => Service['solr'],
  }
}
