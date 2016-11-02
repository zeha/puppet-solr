# solr

[![Puppet Forge](http://img.shields.io/puppetforge/v/landcareresearch/solr.svg)](https://forge.puppetlabs.com/landcaresearch/solr)
[![Bitbucket Build Status](http://build.landcareresearch.co.nz/app/rest/builds/buildType%3A%28id%3ALinuxAdmin_PuppetSolr_PuppetSolr%29/statusIcon)](http://build.landcareresearch.co.nz/viewType.html?buildTypeId=LinuxAdmin_PuppetSolr_PuppetSolr&guest=1)

## About

Installs and configures apache solr and runs the embedded jetty service.
http://lucene.apache.org/solr/

### Solr Versions
* 5.3.x and up   - use solr puppet module 0.5.x
* 5.0.x to 5.2.x - use solr puppet module 0.4.x
* 4.x.x          - use solr puppet module 0.2.2

Supports systemd

## Module Description

This module utilizes the params concept so all default parameters are configured through solr::params.

## Setup

### What solr affects

Installs the following packages
* java 8 jre.

Installs and configures SOLR

## Configuration

solr::params class is used for default configuration, but can be overridden with the specified parameters.

### Parameters

#### `url`
The url of the source repository for apache jetty.
NOTE: If you are installing an older version you may need to specify: 'http://archive.apache.org/dist/lucene/solr/'
Default: 'http://mirrors.gigenet.com/apache/lucene/solr',

#### `timeout`
The timeout used for downloading the solr package.
Default: 120 seconds

#### `version`
The version to install.
Default: '6.1.0'.

#### `solr_user`
Run Solr as this user ID (default: solr)
Note, creates this user if it doesn't exist.

#### `solr_host`
Listen to connections from this network solr_host
Use 0.0.0.0 as solr_host to accept all connections.
Default: 127.0.0.1

#### `solr_port`
The network port used by Jetty
Default Port: 8983

#### `solr_heap`
The heap size used by Jetty
Default size: 512m


#### `solr_downloads`
The download directory, where solr will be downloaded to.
Default: '/opt/solr_downloads'

#### `install_dir`
The install directory for solr.
Default: '/opt/solr'

#### `install_dir_mg`
Sets if this module should manage the install directory.
True if this module should manage and false otherwise.  
Default: false

#### `var_dir`
The data directory for solr.
Default: '/var/solr'

#### `solr_logs`
The directory for the solr logs.
Default: "/var/log/solr"

#### `java_home`
The JAVA_HOME setting.
Default: (os specific)
  * Debian/Ubuntu: '/usr/lib/jvm/java-8-openjdk-amd64/jre'
  * CentOS/RHEL: '/usr/lib/jvm/jre-1.8.0'

#### `solr_environment`
ARRAY - Bash type environment variables passed directly into the SOLR server startup environment
Default: []

#### `cores`
An array of hashes that define a core which will be created with the
create_resources function.
See type solr::core for details.
Default: {}

## Usage

### Simple Use Case

Uses the defaults
```
include solr
```

## Installing Cores

Cores can be installed via the defined type solr::core.  Solr requires a restart when a new core is added.
This module doesn't handle restarting solr for adding new cores.

### Parameters

#### `core_name`
The name of the core (must be unique).  
Default: $title

#### `replace`
Whether or not files should be updated if they are different from the source
specified.  
Default: true

#### `currency_src_file`
The currency file for the core.  It can either be a local file (managed outside
of this module) or a remote file served through a puppet file server (puppet:///).
The default is the example currency file.

#### `protwords_src_file`
The schema file for the core.  It can either be a local file (managed outside
of this module) or a remote file served through a puppet file server (puppet:///).
The default is the example protwords file.

#### `schema_src_file`
The currency file for the core.  It can either be a local file
(managed outside of this module) or a remote file served through a puppet
file server (puppet:///).
The default is the example currency file.

#### `solrconfig_src_file`
The schema file for the core.  It can either be a local file (managed outside
of this module) or a remote file served through a puppet file server (puppet:///).
The default is the example solrconfig file.

#### `stopwords_src_file`
The schema file for the core.  It can either be a local file (managed outside
of this module) or a remote file served through a puppet file server (puppet:///).
The default is the example stopwords file.

#### `synonyms_src_file`
The schema file for the core.  It can either be a local file (managed outside
of this module) or a remote file served through a puppet file server (puppet:///).
The default is the example synonyms file.

### Example

```puppet
file {'/tmp/schema.xml':
  ensure => file,
  content => inline_template('....'),
}

solr::core{'test':
  schema_src_file => '/tmp/schema.xml',
  require         => File ['/tmp/schema.xml'],
}
```

## Installing Shared Libraries

This defined type allows shared libraries to be installed for use by solr.

### Parameters

#### `url`
A file to download and install to the tomcat's lib directory.

#### `filename`
If the name of the file is to be different than the filename from the the url, the name of the file can be set.
Default: undef


#### `path`
The path to copy the file. If setting a custom path, this module does not handle maintaining the path, this is up to the calling module.
Default: $solr::solr_lib_dir

#### `web_user`
The user name of the url to download.
Default: undef

#### `web_password`
The user's password to download the file.
Default: undef

### Example
```
solr::shared_lib{'jts':
  url => 'http://search.maven.org/remotecontent?filepath=com/vividsolutions/jts/1.13/jts-1.13.jar'
}
```

## Limitations

Works with debian and redhat based OS's.

## Development

The module is open source and available on bitbucket.  Please fork!