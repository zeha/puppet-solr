# == Class: solr::config
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
#
# === Copyright
#
# GPL-3.0+
#
class solr::config {

  if $::osfamily == 'debian' {
    file { '/usr/java':
      ensure  => directory,
    }

    # setup a sym link for java home
    file { '/usr/java/default':
      ensure  => 'link',
      target  => '/usr/lib/jvm/java-7-openjdk-amd64',
      require => File['/usr/java'],
    }
  }

  # create the directories
  file { $::solr::solr_logs:
    ensure => directory,
    owner  => $solr::solr_user,
    group  => $solr::solr_user,
  }

  # setup logging
#  file {"${solr::solr_home}/etc/jetty-logging.xml":
#    ensure  => file,
#    owner   => $solr::jetty_user,
#    group   => $solr::jetty_user,
#    source  => 'puppet:///modules/solr/jetty-logging.xml',
#    #require => File["${solr::solr_home}/solr"],
#    require => File[$solr::solr_home_conf],
#  }

  # setup default jetty configuration file.
  file { $::solr::solr_env:
    ensure  => file,
    content => template('solr/solr.in.sh.erb'),
  }

  file { '/etc/init.d/solr':
    ensure  => file,
    mode    => '0755',
    content => template('solr/solr.sh.erb'),
  }

  # setup the service level entry
  if $::solr::params::is_systemd {
    include '::systemd'
    File['/etc/init.d/solr'] ~> Exec['systemctl-daemon-reload']
  }
}
