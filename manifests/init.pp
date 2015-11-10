# == Class: solr
#
# Installs solr using the embedded version of jetty.
# Configures solr and starts the service.
#
# Note, if you are using Centos, you will most likely need to configure
# your firewall rules like so
#     add IP Tables
#     /sbin/iptables -I INPUT 1 -p tcp --dport 8983 -j ACCEPT
#     /sbin/service iptables save
#     service iptables restart
#
# === Parameters
#
# [*url*]
#   The url of the source repository for apache solr.
#   Default: 'http://mirrors.gigenet.com/apache/lucene/solr',
#
# [*version*]
#   The version to install.
#   Default: '4.10.3'.
#
# [*solr_user*]
#   Run Solr as this user ID (default: solr)
#   Note, creates this user.
#
# [*solr_host*]
#   Listen to connections from this network host
#   Use 0.0.0.0 as host to accept all connections.
#   Default: 127.0.0.1
#
# [*solr_port*]
#   The network port used by Jetty
#   Default Port: 8983
#
# [*timeout*]
#   The timeout used for downloading the solr package.
#   Default: 120 seconds.
#
# === Variables
#
# [*solr_home*]
#   The home directory for solr.
#
# [*solr_downloads*]
#   Contains the solr tarballs and extracted dirs.
#
# [*solr_home_src*]
#   The source directory for solr.
#
# [*solr_core_home*]
#   The directory that contains cores.
#
# [*basic_dir*]
#   The directory to the basic configuration example core.
#
# [*solr_lib_dir*]
#   The directory to install shared libraries for use by solr.
#
# === Examples
#
# include solr
#
# === Copyright
#
# GPL-3.0+
#
class solr (
  $url       = $solr::params::url,
  $version   = $solr::params::version,
  $solr_user = $solr::params::solr_user,
  $solr_host = $solr::params::solr_host,
  $solr_port = $solr::params::solr_port,
  $timeout   = $solr::params::timeout,
  $solr_heap = $solr::params::solr_heap,
  $set_gc_logging = $solr::params::set_gc_logging,
  $param_gc_logging = $solr::params::param_gc_logging,

) inherits ::solr::params{

  ## === Variables === ##
  $solr_home      = '/opt/solr'
  $solr_downloads = '/opt/solr_downloads'
  $solr_home_src  = "${solr_downloads}/solr-${version}"
  $solr_logs      = "${solr_home}/logs"
  $solr_env       = '/etc/default/solr'
  $solr_core_home = "${solr_home}/server/solr"
  $basic_dir      = "${solr::solr_core_home}/configsets/basic_configs/conf"
  $solr_lib_dir   = "${solr_home}/server/solr-webapp/webapp/WEB-INF/lib"

  anchor{'solr::begin':}

  class{'solr::install':
    require => Anchor['solr::begin'],
  }

  class{'solr::config':
    require => Class['solr::install'],
  }

  class{'solr::service':
    subscribe => Class['solr::config'],
  }

  anchor{'solr::end':
    require => Class['solr::service'],
  }
}
