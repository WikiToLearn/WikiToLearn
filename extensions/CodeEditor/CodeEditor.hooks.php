<?php

class CodeEditorHooks {
	static function getPageLanguage( Title $title ) {
		global $wgCodeEditorEnableCore;

		if ( $wgCodeEditorEnableCore && method_exists( $title, "hasContentModel" ) ) {
			if ( $title->hasContentModel( CONTENT_MODEL_JAVASCRIPT ) ) {
				return 'javascript';
			} elseif ( $title->hasContentModel( CONTENT_MODEL_CSS ) ) {
				return 'css';
			} elseif ( $title->hasContentModel( CONTENT_MODEL_JSON ) ) {
				return 'json';
			}
		} elseif ( $wgCodeEditorEnableCore && ( $title->isCssOrJsPage() || $title->isCssJsSubpage() ) ) {
			// This block is deprecated. Remove after 1.23 release
			if ( preg_match( '/\.js$/', $title->getText() ) ) {
				return 'javascript';
			}
			if ( preg_match( '/\.css$/', $title->getText() ) ) {
				return 'css';
			}
		}

		// Give extensions a chance
		$lang = null;
		Hooks::run( 'CodeEditorGetPageLanguage', array( $title, &$lang ) );

		return $lang;
	}

	public static function getPreferences( $user, &$defaultPreferences ) {
		$defaultPreferences['usecodeeditor'] = array(
			'type' => 'api',
			'default' => '1',
		);
		return true;
	}

	public static function editPageShowEditFormInitial( $editpage, $output ) {
		$output->addModuleStyles( 'ext.wikiEditor.toolbar.styles' );
		$lang = self::getPageLanguage( $editpage->getContextTitle() );
		if ( $lang && $output->getUser()->getOption( 'usebetatoolbar' ) ) {
			$output->addModules( 'ext.codeEditor' );
		}
		return true;
	}

	public static function onMakeGlobalVariablesScript( &$vars, $output ) {
		$lang = self::getPageLanguage( $output->getTitle() );
		if ( $lang ) {
			$vars['wgCodeEditorCurrentLanguage'] = $lang;
		}
		return true;
	}

	public static function onBeforePageDisplay( $out, $skin ) {
		global $wgCodeEditorGeshiIntegration;
		if ( $wgCodeEditorGeshiIntegration ) {
			$out->addModules( 'ext.codeEditor.geshi' );
		}
		return true;
	}
}
