# == Class: solr::install
#
# Full description of class solr here.
#
# === Parameters
#
#
# === Variables
#
#
# === Examples
#
#  class { 'solr':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Copyright
#
# GPL-3.0+
#
class solr::install {
  
  # install requirements
  ensure_packages($solr::params::required_packages)

  ## create a solr user
  user {$solr::jetty_user:
    ensure     => present,
    home       => $solr::params::solr_home,
    managehome => false,
    shell      => '/bin/bash',
    require    => Package[$solr::params::required_packages]
  }
  
  # download and unpackage solr
  archive { 'solr':
    ensure           => present,
    url              => "${solr::url}/${solr::version}/solr-\
${solr::version}.tgz ",
    target           => '/opt',
    follow_redirects => true,
    extension        => 'tgz',
    checksum         => false,
    require          => User[$solr::jetty_user],
  }

  # copy directory
  exec {'copy solr':
    command     => "/bin/cp -r ${solr::params::solr_home_src}/example \
${solr::params::solr_home}",
    refreshonly => true,
    subscribe   => Archive['solr'],
  }

  # change permissions
  exec {"/bin/chown ${solr::jetty_user}:${solr::jetty_user} -R\
 ${solr::params::solr_home}":
    refreshonly => true,
    subscribe   => Exec['copy solr'],
  }
}