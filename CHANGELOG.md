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
