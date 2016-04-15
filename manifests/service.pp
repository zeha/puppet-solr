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
  service { 'solr':
    ensure => running,
    enable => true,
  }
}
