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

  anchor{'solr::config::begin':}

  if $::osfamily == 'debian' {
    file { '/usr/java':
      ensure  => directory,
      require => Anchor['solr::config::begin'],
    }

    # setup a sym link for java home
    file { '/usr/java/default':
      ensure  => 'link',
      target  => '/usr/lib/jvm/java-7-openjdk-amd64',
      require => File['/usr/java'],
      before  => File[$::solr::solr_logs],
    }
  }

  # create the directories
  file { $::solr::solr_logs:
    ensure  => directory,
    owner   => $solr::solr_user,
    group   => $solr::solr_user,
    require => Anchor['solr::config::begin'],
  }

  # setup default jetty configuration file.
  file { $::solr::solr_env:
    ensure  => file,
    content => template('solr/solr.in.sh.erb'),
    require => File[$::solr::solr_logs],
  }

  file { '/etc/init.d/solr':
    ensure  => file,
    mode    => '0755',
    content => template('solr/solr.sh.erb'),
    require => File[$::solr::solr_env],
  }

  # setup the service level entry
  if $::solr::params::is_systemd {
    include '::systemd'
    File['/etc/init.d/solr'] ~> Exec['systemctl-daemon-reload']
  }
  anchor{'solr::config::end':
    require => File['/etc/init.d/solr'],
  }
}