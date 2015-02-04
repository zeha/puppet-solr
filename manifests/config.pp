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
  
  # make OS specific changes
  case $::osfamily {
    'redhat': { }
    'debian':{
      file {'/usr/java':
        ensure => directory,
      }

      # setup a sym link for java home
      file {'/usr/java/default':
        ensure  => 'link',
        target  => '/usr/lib/jvm/java-7-openjdk-amd64',
        require => File['/usr/java'],
        before  => File['/etc/default/jetty'],
      }
    }
    default: {
      fail("Unsupported OS ${::osfamily}.  Please use a debian or \
redhat based system")
    }
  }

  # setup logging
  file {"${solr::params::solr_home}/etc/jetty-logging.xml":
    ensure => file,
    owner  => $solr::jetty_user,
    group  => $solr::jetty_user,
    source => 'puppet:///modules/solr/jetty-logging.xml',
  }

  # setup default jetty configuration file.
  file {'/etc/default/jetty':
    ensure  => file,
    content => template('solr/jetty.erb')
  }

  # setup the service level entry
  file {'/etc/init.d/jetty':
    ensure  => file,
    mode    => '0755',
    content => template('solr/jetty.sh.erb'),
  }

  # log file for jetty
  file {'/var/log/jetty':
    ensure  => directory,
  }

  file {'/var/cache/jetty':
    ensure  => directory,
  }

  # make sure solr owns contents of solr dir.
#  file {'/opt/solr':
#    ensure  => directory,
#    owner   => 'solr',
#    recurse => true,
#    #require => User['solr'],
#  }
}
