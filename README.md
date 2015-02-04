# solr

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

## License

GPL version 3

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, [see](http://www.gnu.org/licenses/).
