# solr

[![Puppet Forge](http://img.shields.io/puppetforge/v/landcareresearch/solr.svg)](https://forge.puppetlabs.com/landcaresearch/solr)
[![Bitbucket Build Status](http://build.landcareresearch.co.nz/app/rest/builds/buildType%3A%28id%3ALinuxAdmin_PuppetSolr_PuppetSolr%29/statusIcon)](http://build.landcareresearch.co.nz/viewType.html?buildTypeId=LinuxAdmin_PuppetSolr_PuppetSolr&guest=1)

## About

Installs and configures apache solr and runs the embedded jetty service.
http://lucene.apache.org/solr/

Originally, this module supported solr 4.x.  However, version 0.3.0 has been upgraded to work with solar 5.x and no longer supports 4.x
So if you want to use solr 4.x, than please continue to use 0.2.2.

Supports systemd

## Module Description

This module utilizes the params concept so all default parameters are configured through solr::params.

## Setup

### What solr affects

Installs the following packages
* java 7 jre.

## Configuration

solr::params class is used for configuration, but can be overridden with the specified parameters.

### Parameters

#### `url`
The url of the source repository for apache jetty.
Default: 'http://mirrors.gigenet.com/apache/lucene/solr',

#### `version`
The version to install.
Default: '4.10.4'.

#### `solr_user`
Run Solr as this user ID (default: solr)
Note, creates this user.

#### `solr_host`
Listen to connections from this network host
Use 0.0.0.0 as host to accept all connections.
Default: 127.0.0.1

#### `solr_port`
The network port used by Jetty
Default Port: 8983

#### `timeout`
The timeout used for downloading the solr package.
Default: 120 seconds

#### `solr_heap`
The heap size used by Jetty
Default size: 1024m

#### `cores`
An array of hashes that define a core which will be created with the
create_resources function.
See type solr::core for details.
Default: {}

#### `solr_home`
The home directory for solr.
Default: '/opt/solr'

#### `solr_logs`
The directory for the solr logs.
Default: "${solr_home}/logs"

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