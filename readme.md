API Development Profile
=======================

This is an installation profile for developing and testing the API module.

Details
-------

The build file will download and prepare a Drupal source tree containing the
following:

* Drupal 6.x core.
* API module 6.x-1.x cloned from git.
* Simpletest module including the required core patch and the optional "show
  fatal errors in tests" patch.
* Grammar parser, autoload, ctools, devel, and drupal_queue modules.

The profile will enable the above modules and import some standard branch data
used by the API module tests.

Dependencies
------------

* Drush 5.x (or an older version of drush and drush make).

Usage
-----

```
drush make /path/to/api_dev.build [target]
```

If you want to stop drush make from adding metadata to info files you should
invoke drush with the --no-gitinfofile option.

```
drush make --working-copy --no-gitinfofile --prepare-install --contrib-destination=sites/all /path/to/api_dev.build [target]
```

There is currently an implementation of hook_requirements which would stall the installation. The patch hosted on github removes the hook_requirements function altogether so the installer can run. To reverse this patch and get API module back to its initial state, run the following command:

```
curl https://raw.github.com/gist/1872130/52d2724608d46163c29d284fdba9500f2b853e6f/gistfile1.diff | git apply -R
```

