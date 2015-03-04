# solr

[![Puppet Forge](http://img.shields.io/puppetforge/v/landcareresearch/solr.svg)](https://forge.puppetlabs.com/landcaresearch/amazon_s3)
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

## Limitations

Works with debian and redhat based OS's.

## Development

The module is open source and available on github.  Please fork!
