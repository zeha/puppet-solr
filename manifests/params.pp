# == Class: solr::params
#
# The paramteres class for solr.
#
# === Variables
#
# [*url*]
#   The url of the source repository for apache solr.
#   Default: 'http://mirrors.gigenet.com/apache/lucene/solr',
#
# [*version*]
#   The version to install.
#   Default: '5.5.2'.
#
# [*manage_user*]
#   Whether to manage the solr user or not
#   Default: true
#
# [*solr_user*]
#   Run Solr as this user ID
#   Note, creates this user.
#   Default: solr
#
# [*solr_host*]
#   Listen to connections from this network host
#   Use 0.0.0.0 as host to accept all connections.
#   Default: 127.0.0.1
#
# [*solr_port*]
#   The network port used by Solr
#   Default Port: 8983
#
# [*timeout*]
#   The timeout used for downloading the solr package.
#   Default: 120 seconds.
#
# [*solr_heap*]
#   The heap size used by jetty.
#   Default: 512m
#
# [*log4j_maxfilesize*]
#   Maximum allowed log file size (in bytes) before rolling over. Suffixes "KB", "MB" and "GB" are allowed.
#   Default: 4MB
#
# [*log4j_maxbackupindex*]
#   Maximum number of log backup files to keep.
#   Default: 9
#
# === Copyright
#
# GPL-3.0+
#
class solr::params (
){
  $url                  = 'http://archive.apache.org/dist/lucene/solr/'
  $version              = '6.2.0'
  $manage_user          = true
  $solr_user            = 'solr'
  $solr_host            = '127.0.0.1'
  $solr_port            = '8983'
  $timeout              = '120'
  $solr_heap            = '512m'
  $solr_downloads       = '/opt/solr_downloads'
  $solr_logs            = '/var/log/solr'
  $install_dir          = '/opt'
  $install_dir_mg       = false
  $var_dir              = '/var/solr'
  $zk_hosts             = []
  $log4j_maxfilesize    = '4MB'
  $log4j_maxbackupindex = '9'

  # OS Specific configuration
  case $::osfamily {
    'RedHat': {
      $required_packages  = ['java-1.8.0-openjdk','unzip','lsof']
      $java_home = '/usr/lib/jvm/jre-1.8.0'
      $solr_env = '/etc/sysconfig/solr'
      if versioncmp($::operatingsystemrelease, '7.0') >= 0 {
        $is_systemd = true
      } else {
        $is_systemd = false
      }

      # java8 module for installing oracle java on debian systems
      $use_java_module = false
    }
    'debian':{
      $java_home = '/usr/lib/jvm/java-8-oracle/jre'
      $solr_env = '/etc/default/solr'
      if $::operatingsystem == 'Ubuntu' and
      versioncmp($::operatingsystemrelease, '15.04') >= 0 {
        $is_systemd = true
        $required_packages = ['unzip','lsof','software-properties-common']
      } else {
        $is_systemd = false
        $required_packages = ['unzip','lsof']
      }
      # java8 module for installing oracle java on debian systems
      $use_java_module = true
    }
    default: {
      fail("Unsupported OS ${::osfamily}.\
  Please use a debian or redhat based system")
    }
  }
}
