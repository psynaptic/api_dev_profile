; Stub make file for api_dev profile

; Drush make

api = 2

; Drupal core

core = 6.x
projects[drupal][version] = 6

; Contributed modules

projects[] = api
projects[] = ctools
projects[] = devel
projects[] = drupal_queue

projects[grammar_parser][type] = module
projects[grammar_parser][download][type] = git
projects[grammar_parser][download][url] = http://git.drupal.org/project/grammar_parser.git
projects[grammar_parser][download][tag] = 7.x-1.1
projects[grammar_parser][patch][994518][url] = "http://drupal.org/files/issues/994518.patch"
projects[grammar_parser][patch][994518][md5] = "eecc6f6aa76d0cc399fb4bf8300edcec"

projects[] = simpletest
projects[drupal][patch][] = "http://drupalcode.org/project/simpletest.git/blob_plain/refs/heads/6.x-2.x:/D6-core-simpletest.patch"
projects[drupal][patch][] = "http://drupal.org/files/issues/simpletest_drupal.js_.patch"
