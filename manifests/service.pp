# == Class: solr::service
#
# Manages the service for solr.
#
# === Parameters
#
# === Variables
#
# === Copyright
#
# GPL-3.0+
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
