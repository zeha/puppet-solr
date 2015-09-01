# == Class: solr::params
#
# Full description of class solr here.
#
# === Variables
#
# [*url*]
#   The url of the source repository for apache solr.
#   Default: 'http://mirrors.gigenet.com/apache/lucene/solr',
#
# [*version*]
#   The version to install.
#   Default: '5.3.0'.
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
#   The network port used by Solr
#   Default Port: 8983
#
# [*timeout*]
#   The timeout used for downloading the solr package.
#   Default: 120 seconds.
#
# === Examples
#
#
# === Copyright
#
# GPL-3.0+
#
class solr::params (
){

  $url       = 'http://mirrors.gigenet.com/apache/lucene/solr'
  $version   = '5.3.0'
  $solr_user = 'solr'
  $solr_host = '127.0.0.1'
  $solr_port = '8983'
  $timeout   = '120'

  # OS Specific configuration
  case $::osfamily {
      'redhat': {
        $required_packages  = ['java-1.7.0-openjdk','unzip']
        $java_home = '/usr/lib/jvm/jre-1.7.0-openjdk.x86_64'

      }
      'debian':{
        $required_packages = ['openjdk-7-jre','unzip']
        $java_home = '/usr/lib/jvm/java-7-openjdk-amd64/jre'
      }
      default: {
        fail("Unsupported OS ${::osfamily}.  Please use a debian or \
redhat based system")
      }
  }
}
