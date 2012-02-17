<?php
/**
 * @file
 * Install profile for developing and testing the API module.
 */

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
    'comment', 'help', 'menu', 'watchdog',

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
    'name' => 'API module development profile',
    'description' => 'This profile is for developing and testing the API module.',
  );
}

/**
 * Perform any final installation tasks for this profile.
 *
 * @return
 *   An optional HTML string to display to the user on the final installation
 *   screen.
 */
function api_dev_profile_final() {
}

