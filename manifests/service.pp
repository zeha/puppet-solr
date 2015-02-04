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
  service {'jetty':
    ensure => running,
  }
}