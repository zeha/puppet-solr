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
