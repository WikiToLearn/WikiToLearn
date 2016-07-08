<?php
/**
 * Hooks for TemplateData extension
 *
 * @file
 * @ingroup Extensions
 */

class TemplateDataHooks {
	/**
	 * Register parser hooks
	 */
	public static function onParserFirstCallInit( &$parser ) {
		$parser->setHook( 'templatedata', array( 'TemplateDataHooks', 'render' ) );
		return true;
	}

	/**
	 * Register unit tests
	 */
	public static function onUnitTestsList( array &$files ) {
		$testDir = __DIR__ . '/tests/';
		$files = array_merge( $files, glob( "$testDir/*Test.php" ) );
		return true;
	}

	/**
	 * Register qunit unit tests
	 */
	public static function onResourceLoaderTestModules(
		array &$testModules,
		ResourceLoader &$resourceLoader
	) {
		$testModules['qunit']['ext.templateData.test'] = array(
			'scripts' => array( 'tests/ext.templateData.tests.js' ),
			'dependencies' => array( 'ext.templateDataGenerator.data' ),
			'localBasePath' => __DIR__ ,
			'remoteExtPath' => 'TemplateData',
		);
		return true;
	}

	/**
	 * Conditionally register the jquery.uls.data module, in case they've already been
	 * registered by the UniversalLanguageSelector extension or the VisualEditor extension.
	 *
	 * @param ResourceLoader $resourceLoader
	 * @return boolean true
	 */
	public static function onResourceLoaderRegisterModules( ResourceLoader &$resourceLoader ) {
		$resourceModules = $resourceLoader->getConfig()->get( 'ResourceModules' );
		$name = 'jquery.uls.data';
		if ( !isset( $resourceModules[$name] ) && !$resourceLoader->isModuleRegistered( $name ) ) {
			$resourceLoader->register( array(
				'jquery.uls.data' => array(
					'localBasePath' => __DIR__,
					'remoteExtPath' => 'TemplateData',
					'scripts' => array(
						'lib/jquery.uls/src/jquery.uls.data.js',
						'lib/jquery.uls/src/jquery.uls.data.utils.js',
					),
					'targets' => array( 'desktop', 'mobile' ),
				)
			) );
		}
	}

	/**
	 * @param Page &$page
	 * @param User &$user
	 * @param Content &$content
	 * @param string &$summary
	 * @param $minor
	 * @param bool|null $watchthis
	 * @param $sectionanchor
	 * @param &$flags
	 * @param Status &$status
	 */
	public static function onPageContentSave( &$page, &$user, &$content, &$summary, $minor,
		$watchthis, $sectionanchor, &$flags, &$status
	) {

		// The PageContentSave hook provides raw $text, but not $parser because at this stage
		// the page is not actually parsed yet. Which means we can't know whether self::render()
		// got a valid tag or not. Looking at $text directly is not a solution either as
		// it may not be in the current page (it can be transcluded).
		// Since there is no later hook that allows aborting the save and showing an error,
		// we will have to trigger the parser ourselves.
		// Fortunately this causes no overhead since the below (copied from WikiPage::doEditContent,
		// right after this hook is ran) has guards that lazy-init and return early if called again
		// later by the real WikiPage.

		// Specify format the same way the API and EditPage do to avoid extra parsing
		$format = $content->getContentHandler()->getDefaultFormat();
		$editInfo = $page->prepareContentForEdit( $content, null, $user, $format );

		if ( isset( $editInfo->output->ext_templatedata_status ) ) {
			$validation = $editInfo->output->ext_templatedata_status;
			if ( !$validation->isOK() ) {
				// Abort edit, show error message from TemplateDataBlob::getStatus
				$status->merge( $validation );
				return false;
			}
		}
		return true;
	}

	/**
	 * Parser hook registering the GUI module only in edit pages.
	 *
	 * @param EditPage $editPage
	 * @param OutputPage $output
	 * @return bool
	 */
	public static function onEditPage( $editPage, $output ) {
		global $wgTemplateDataUseGUI;
		if ( $wgTemplateDataUseGUI ) {
			if ( $output->getTitle()->getNamespace() === NS_TEMPLATE ) {
				$output->addModules( 'ext.templateDataGenerator.editPage' );
			}
		}
		return true;
	}

	/**
	 * Parser hook for <templatedata>.
	 * If there is any JSON provided, render the template documentation on the page.
	 *
	 * @param string $input: The content of the tag.
	 * @param array $args: The attributes of the tag.
	 * @param Parser $parser: Parser instance available to render
	 *  wikitext into html, or parser methods.
	 * @param PPFrame $frame: Can be used to see what template parameters ("{{{1}}}", etc.)
	 *  this hook was used with.
	 *
	 * @return string: HTML to insert in the page.
	 */
	public static function render( $input, $args, $parser, $frame ) {
		$parser->enableOOUI();
		$ti = TemplateDataBlob::newFromJSON( $input );

		$status = $ti->getStatus();
		if ( !$status->isOK() ) {
			$parser->getOutput()->ext_templatedata_status = $status;
			return '<div class="errorbox">' . $status->getHtml() . '</div>';
		}

		$parser->getOutput()->setProperty( 'templatedata', $ti->getJSONForDatabase() );

		$parser->getOutput()->addModuleStyles( 'ext.templateData' );

		return $ti->getHtml( $parser->getOptions()->getUserLangObj() );
	}
}
