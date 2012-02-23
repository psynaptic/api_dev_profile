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
  _api_dev_tests_branch_data_import();
  _api_dev_php_branch_data_import();
  _api_dev_set_blocks();
}

function _api_dev_set_blocks() {
  $blocks = array();

  $blocks['api_navigation'] = array(
    'module' => 'api',
    'delta' => 'navigation',
    'region' => 'left',
    'weight' => -10,
  );
  $blocks['api_search'] = array(
    'module' => 'api',
    'delta' => 'api-search',
    'region' => 'left',
    'weight' => -9,
  );
  $blocks['devel_menu'] = array(
    'module' => 'menu',
    'delta' => 'devel',
    'region' => 'left',
    'weight' => -8,
  );

  // Populate the blocks table.
  _block_rehash();

  foreach ($blocks as $block) {
    db_query("UPDATE {blocks} SET status = 1, region = '%s', theme = 'garland' WHERE module = '%s' AND delta = '%s'", $block['region'], $block['module'], $block['delta']);
  }
}

/**
 * Imports API Tests branch data for running simpletests against.
 */
function _api_dev_tests_branch_data_import() {
  $document_root = str_replace('install.php', '', $_SERVER['SCRIPT_FILENAME']);

  $branch = (object) array(
    'branch_name' => 'tests',
    'project' => 'api',
    'type' => 'files',
    'title' => st('API Tests'),
    'project_title' => 'api',
    'status' => 1,
    'data' => array(
      'directories' => $document_root . drupal_get_path('module', 'api') . '/tests/sample',
      'excluded_directories' => '',
    ),
  );

  // Insert the new branch data.
  db_query('INSERT INTO {api_branch} (branch_name, project, type, title, project_title, status, data) VALUES ("%s", "%s", "%s", "%s", "%s", %d, "%s")', $branch->branch_name, $branch->project, $branch->type, $branch->title, $branch->project_title, $branch->status,  serialize($branch->data));
}

/**
 * Adjusts the default PHP branch to use the settings needed for simpletest.
 */
function _api_dev_php_branch_data_import() {
  // Calculate the base URL to be used for the function summary file URL.
  $base_url = $_SERVER['HTTP_ORIGIN'] . str_replace('install.php', '', $_SERVER['SCRIPT_NAME']);

  // Generate the required branch data to be injected into the database.
  $branch_data = array(
    'summary' => $base_url . drupal_get_path('module', 'api') . '/tests/php_sample/funcsummary.txt',
    'path' => 'http://example.com/function/!function',
  );

  // The branch_id for the PHP branch should always be 1 but we'll check anyway
  // to be absolutely sure.
  $branch_id = db_result(db_query('SELECT branch_id FROM {api_branch} WHERE branch_name = "php"'));

  // Update the PHP branch with the new data.
  db_query('UPDATE {api_branch} SET data = "%s" WHERE branch_id = %d', serialize($branch_data), $branch_id);
}

