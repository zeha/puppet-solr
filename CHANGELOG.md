## 2016-06-28 Release 0.3.7

### Summary
Core Config Customization

### Changed
  - Added the flexibility of specifying additional core configuration parameters.
  - Added parameters for changing the home and logs dirs.
  - Changed default solr version to 5.5.2

## 2016-03-21 Release 0.3.6
### Summary
Added systemd and addition options

### Changed
 - Added support for systemd
 - Added new parameter to set the jetty heap size

## 2015-10-19 Release 0.3.2
### Summary
Added Package

### Changed
 - [Issue #2](https://jira.landcareresearch.co.nz/browse/DEVOPSPN-359) - added package lsof.

## 2015-09-02 Release 0.3.1
### Summary
Hotfix

### Changed
 - Fixed a dependency issue causing a fatal installation error.

### Known Issues
 - Solr service does not start.  Requires a manual ```service solr start```

## 2015-09-02 Release 0.3.2
### Summary
Hotfix

### Changed
 - The owner/group of logs directory.

## 2015-09-01 Release 0.3.1
### Summary
Added shared libraries

### Changed
 - Added a mechanism to install shared libraries for solr.
 - Changed default version of solr from 4.10.3 to 5.3.0.
 - Fixed readme typos.

## 2015-09-01 Release 0.3.0
### Summary
Migrated to Solr 5.x

### Changed
 - Added compatability for Solr 5.x
 - Is no longer compatible with Solr 4.x
 - Removed puppet archive requirement
 - Added puppet wget requirement

## 2015-03-17 Release 0.2.3
### Summary
Updates

### Changed
 - Updated Readme to reflect migration to bitbucket and removed author as to promote open source.

## 2015-03-17 Release 0.2.2
### Summary
Fixed version issue

### Changed
 - There was an issue with the version that was dependant on the version in the params instead of the specified version.

## 2015-03-17 Release 0.2.1
### Summary
Setting Java_Home

### Changed
 - Set the java home & java path so that jetty uses the defined java within solr 
   currently using java 7.


## 2015-03-16 Release 0.2.0
### Summary
Added params

### Changed
 - Added a timeout param for downloading the solr package.
 - Added a variable to ensure the solr/conf directory is created and managed by puppet.
 - Removed parameters from params class and made into variables.  
 - Moved variables depending on user settings into init.pp
 - Added a defined type for installing cores based on the collections1 example.
 - Fixed incorrect puppetforge badge.

### Known Issues
 - Does not work with Solr 5.0.x

## 2015-03-04 Release 0.1.1
### Summary
Account Migration

### Changed
 - Migrated from github to bitbucket
 - Changed ownership of puppetforge account
 - Created Changelog file.
