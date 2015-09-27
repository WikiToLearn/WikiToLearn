<?php
/**
 * This file was copied from CakePhps codesniffer tests before being modified
 * https://github.com/cakephp/cakephp-codesniffer/blob/7abb71ed17a52beb16e208d6964f7c9d967e639d/CakePHP/tests/TestHelper.php
 *
 * @license MIT
 * CakePHP(tm) : The Rapid Development PHP Framework (http://cakephp.org)
 * Copyright (c) 2005-2013, Cake Software Foundation, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * @author Adam Shorland
 * Modifications
 *  - runPhpCs takes a second parameter $standard to override the default
 */

class TestHelper {

	protected $_rootDir;

	protected $_dirName;

	protected $_phpcs;

	public function __construct() {
		$this->_rootDir = dirname(dirname(__FILE__));
		$this->_dirName = basename($this->_rootDir);
		$this->_phpcs = new PHP_CodeSniffer_CLI();
	}

	/**
	 * Run PHPCS on a file.
	 *
	 * @param string $file to run.
	 * @param string $standard to run against
	 * @return string The output from phpcs.
	 */
	public function runPhpCs($file, $standard = '') {
		if( empty( $standard ) ){
			$standard = $this->_rootDir . '/ruleset.xml';
		}
		$defaults = $this->_phpcs->getDefaults();
		//$standard = $this->_rootDir . '/ruleset.xml';
		if (
			defined('PHP_CodeSniffer::VERSION') &&
			version_compare(PHP_CodeSniffer::VERSION, '1.5.0') != -1
		) {
			$standard = array($standard);
		}
		$options = array(
				'encoding' => 'utf-8',
				'files' => array($file),
				'standard' => $standard,
			) + $defaults;

		// New PHPCS has a strange issue where the method arguments
		// are not stored on the instance causing weird errors.
		$reflection = new ReflectionProperty($this->_phpcs, 'values');
		$reflection->setAccessible(true);
		$reflection->setValue($this->_phpcs, $options);

		ob_start();
		$this->_phpcs->process($options);
		$result = ob_get_contents();
		ob_end_clean();
		return $result;
	}

}