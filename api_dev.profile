<?php
/**
 * @file
 * Install profile for developing and testing the API module.
 */

// Fake the simpletest install requirements.
$GLOBALS['simpletest_installed'] = TRUE;

/**
 * Return an array of the modules to be enabled when this profile is installed.
 *
 * @return
 *   An array of modules to be enabled.
 */
function api_dev_profile_modules() {
  return array(
    // Enable essential core module.
    'block', 'filter', 'node', 'system', 'user',
    
    // Enable optional core module.
    'comment', 'help', 'menu', 'dblog',

    // Enable contributed modules.
    'api', 'ctools', 'devel', 'drupal_queue', 'grammar_parser', 'simpletest',
  );
}

/**
 * Return a description of the profile for the initial installation screen.
 *
 * @return
 *   An array with keys 'name' and 'description' describing this profile.
 */
function api_dev_profile_details() {
  return array(
    'name' => 'API development profile',
    'description' => 'Select this profile to install and configure Drupal for developing and testing the API module.',
  );
}

/**
 * Perform any final installation tasks for this profile.
 *
 * @return
 *   An optional HTML string to display to the user on the final installation
 *   screen.
 */
function api_dev_profile_tasks() {
  // Calculate the base URL to be used for the function summary file URL.
  $base_url = $_SERVER['HTTP_ORIGIN'] . str_replace('install.php', '', $_SERVER['SCRIPT_NAME']);

  // The branch_id for the PHP branch should always be 1 but we'll check anyway
  // to be absolutely sure.
  $php_branch_object = db_fetch_object(db_query('SELECT branch_id FROM {api_branch} WHERE branch_name = "php"'));
  $php_branch_id = $php_branch_object->branch_id;

  // Generate the required branch data to be injected into the database.
  $php_branch_data = array(
    'summary' => $base_url . drupal_get_path('module', 'api') . '/tests/php_sample/funcsummary.txt',
    'path' => 'http://example.com/function/!function',
  );

  // Update the PHP branch with the new data.
  db_query('UPDATE {api_branch} SET data = "%s" WHERE branch_id = %d', serialize($php_branch_data), $php_branch_id);

  $document_root = str_replace('install.php', '', $_SERVER['SCRIPT_FILENAME']);
  // Insert the new branch data.
  $api_tests_branch_data = array(
    'directories' => $document_root . drupal_get_path('module', 'api') . '/tests/sample',
    'excluded_directories' => '',
  );
  db_query('INSERT INTO {api_branch} (branch_name, project, type, title, project_title, status, data) VALUES ("tests", "api", "files", "API Tests", "api", 1, "%s")', serialize($api_tests_branch_data));
}

