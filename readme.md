API Development Profile
=======================

This is an installation profile for development and testing of the Drupal API
module.

The build file contains:

* Drupal 6.x
* API module 6.x-1.x cloned from git
* Simpletest module including the required core patch and the optional "show
  fatal errors in tests" patch.
* Grammar parser, autoload, ctools, devel, drupal_queue

DEPENDENCIES
------------

* Drush 5.x (or Drush and Drush make)

USAGE
-----

```
drush make /path/to/api_dev.build <target>
```

If you want to stop drush make from adding metadata to info files you should
invoke drush make with the --no-gitinfofile option.

```
drush make --working-copy --no-gitinfofile --prepare-install --contrib-destination=sites/all /path/to/api_dev.build <target>
```

