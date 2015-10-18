# == Class: solr::service
#
# === Parameters
#
#
# === Variables
#
# === Examples
#
#
# === Copyright
#
# GPL-3.0+
#
class solr::service {
  anchor {'solr::service::begin':}
  service {'solr':
    ensure  => running,
    require => Anchor['solr::service::begin'],
  }
  anchor {'solr::service::end':
    require => Service['solr'],
  }
}
