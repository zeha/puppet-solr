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
# [*version*]
#   The version to install.
#   Default: 6.1.0
#
# [*url*]
#   The url of the source repository for apache solr.
#   Default: 'http://mirrors.gigenet.com/apache/lucene/solr',
#
# [*timeout*]
#   The timeout used for downloading the solr package.
#   Default: 120 seconds.
#
# [*solr_user*]
#   Run Solr as this user ID (default: solr)
#   Note, creates this user.
#
# [*solr_host*]
#   Listen to connections from this network host
#   Use 0.0.0.0 as solr_host to accept all connections.
#   Default: 127.0.0.1
#
# [*solr_port*]
#   The network port used by Jetty
#   Default Port: 8983
#
# [*solr_heap*]
#   The heap size used by jetty.
#   Default: 512m
#
# [*solr_downloads*]
#   Contains the solr tarballs and extracted dirs.
#
#
# [*install_dir*]
#   The install directory (`-i`) parameter passed to the solr installer.
#   Default: '/opt'
#
# [*solr_home*]
#   The home directory for solr.
#   Default: "${install_dir}/solr" (/opt/solr)
#
# [*var_dir*]
#   The var directory for solr.
#   Default: '/var/solr'
#
# [*solr_logs*]
#   The directory for the solr logs.
#   Default: "/var/log/solr"
#
# [*solr_environment*]
#   ARRAY - Bash style environment variables passed at the end of the solr
#   server environment.
#   Default: []
#
# [*cores*]
#   An array of hashes that define a core which will be created with the
#   create_resources function.
#   See type solr::core for details.
#   Default: {}
#
# === Variables
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
  $version          = $solr::params::version,
  $url              = $solr::params::url,
  $timeout          = $solr::params::timeout,
  $user             = $solr::params::user,
  $solr_host        = $solr::params::solr_host,
  $solr_port        = $solr::params::solr_port,
  $heap             = $solr::params::heap,
  $solr_downloads   = $solr::params::solr_downloads,
  $install_dir      = $solr::params::install_dir,
  $var_dir          = $solr::params::var_dir,
  $solr_logs        = $solr::params::solr_logs,
  $java_home        = $solr::params::java_home,
  $solr_environment = [],
  $cores            = {},
  $required_packages= $solr::params::required_packages,
) inherits ::solr::params{

  ## === Variables === ##
  $solr_home      = "${var_dir}/data"
  $solr_env       = $solr::params::solr_env
  $solr_core_home = $solr_home
  $solr_pid_dir   = $var_dir
  $solr_bin       = "${install_dir}/solr/bin"
  $solr_server    = "${install_dir}/solr/server"
  $basic_dir      = "${solr_server}/solr/configsets/basic_configs/conf"
  $solr_lib_dir   = "${solr_server}/solr-webapp/webapp/WEB-INF/lib"


  # The schema filename is managed-schema in 5.5+
  if versioncmp($solr::version, '5.5.0') >= 0 {
    $schema_filename = 'managed-schema'
  } else {
    $schema_filename = 'schema.xml'
  }

  anchor{'solr::begin': }

  class{'solr::install':
    require => Anchor['solr::begin'],
  }

  class{'solr::config':
    require => Class['solr::install'],
  }

  class{'solr::service':
    subscribe => Class['solr::config'],
  }

  if is_hash($cores) {
    create_resources(::solr::core, $cores)
  }

  anchor{'solr::end':
    require => Class['solr::service'],
  }
}
