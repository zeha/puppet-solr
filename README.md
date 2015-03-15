# solr

[![Puppet Forge](http://img.shields.io/puppetforge/v/landcareresearch/solr.svg)](https://forge.puppetlabs.com/landcaresearch/solr)
[![Bitbucket Build Status](http://build.landcareresearch.co.nz/app/rest/builds/buildType%3A%28id%3ALinuxAdmin_PuppetSolr_PuppetSolr%29/statusIcon)](http://build.landcareresearch.co.nz/viewType.html?buildTypeId=LinuxAdmin_PuppetSolr_PuppetSolr&guest=1)

Author: Michael Speth <spethm@landcareresearch.co.nz>

## About

Installs and configures apache solr and runs the embedded jetty service.
http://lucene.apache.org/solr/

## Module Description

This module utilizes the params concept so all parameters are configured
through solr::params.

## Setup

### What solr affects

Installs the following packages
* java 7 jre.

## Configuration

solr::params class is used for configuration.
But can be overridden with the specified parameters.

### Parameters

#### `url`
The url of the source repository for apache jetty.
Default: 'http://mirrors.gigenet.com/apache/lucene/solr',

#### `version`
The version to install.
Default: '4.10.3'.

#### `jetty_user`
Run Jetty as this user ID (default: solr)
Note, creates this user.

#### `jetty_host`
Listen to connections from this network host
Use 0.0.0.0 as host to accept all connections.
Default: 127.0.0.1

#### `jetty_port`
The network port used by Jetty
Default Port: 8983

## Usage

### Simple Use Case

Uses the defaults
```
include solr
```

## Installing Cores

Cores can be installed via the defined type solr::core.  Solr should pick up the new cores without needing to do a refresh.

### Parameters

#### `core_name`
The name of the core (must be unique).
Default: $title

#### `schema_src_file`
The schema file must exist on the file system and should be controlled
outside of this module.  This will simply link the schema file to 
Required

### Example

file {'/tmp/schema.xml':
  ensure => file,
  content => inline_template('....'),
}

solr::core{'test':
  schema_src_file => '/tmp/schema.xml',
  require         => File ['/tmp/schema.xml'],
}


## Limitations

Works with debian and redhat based OS's.

## Development

The module is open source and available on github.  Please fork!
