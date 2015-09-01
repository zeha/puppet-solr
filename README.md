# solr

[![Puppet Forge](http://img.shields.io/puppetforge/v/landcareresearch/solr.svg)](https://forge.puppetlabs.com/landcaresearch/solr)
[![Bitbucket Build Status](http://build.landcareresearch.co.nz/app/rest/builds/buildType%3A%28id%3ALinuxAdmin_PuppetSolr_PuppetSolr%29/statusIcon)](http://build.landcareresearch.co.nz/viewType.html?buildTypeId=LinuxAdmin_PuppetSolr_PuppetSolr&guest=1)

## About

Installs and configures apache solr and runs the embedded jetty service.
http://lucene.apache.org/solr/

Originally, this module supported solr 4.x.x.  However, version 0.3.0 has been upgradted to work with solar 5.x and no longer supports 4.x
So if you want to use solr 4.x, than please continue to use 0.2.2.

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

#### `schema_src_file`
The schema file must exist on the file system and should be controlled outside of this module.  This will simply link to the schema file.
Default: the basic example core's schema.

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


## Limitations

Works with debian and redhat based OS's.

## Development

The module is open source and available on bitbucket.  Please fork!
