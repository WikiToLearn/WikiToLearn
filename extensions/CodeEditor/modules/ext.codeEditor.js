/**
 * MediaWiki:Gadget-codeeditor.js
 * (c) 2011 Brion Vibber <brion @ pobox.com>
 * GPLv2 or later
 *
 * Syntax highlighting, auto-indenting code editor widget for on-wiki JS and CSS pages.
 * Uses embedded Ajax.org Cloud9 Editor: https://ace.c9.io/
 *
 * Browsers tested:
 * - Firefox 4.0 / Linux
 * - Chrome 10.0.648.204 / Linux
 *
 * Browsers tested with issues:
 * - Opera 11.10 / Linux: copy fails, paste sometimes crashes
 * - IE 8.0.6001.18702 / Win XP: some newlines mysteriously removed, corrupting data;
 *   insertion point keeps resetting back to the top of the page after a click (arrow keys ok)
 * - Safari / iPad 4.3 (8F190): renders ok, but can't set focus or scroll vertically. No focus means no typing. :(
 *   There is some work in progress that needs merging upstream...
 *   https://github.com/ajaxorg/ace/issues/37
 *
 * Known issues:
 * - extension version doesn't have optional bits correct
 * - ties into WikiEditor, so doesn't work on classic toolbar
 * - background worker for JS syntax check doesn't load in non-debug mode (probably also fails if extension assets are offsite)
 * - copy/paste not available from context menu (Firefox, Chrome on Linux -- kbd & main menu commands ok)
 * - accessibility: tab/shift-tab are overridden. is there a consistent alternative for keyboard-reliant users?
 * - accessibility: accesskey on the original textarea needs to be moved over or otherwise handled
 * - 'discard your changes?' check on tab close doesn't trigger
 * - scrollbar initializes too wide; need to trigger resize check after that's filled
 * - cursor/scroll position not maintained over previews/show changes
 *
 * Reported upstream:
 * - ctrl+R, ctrl+L, ctrl+T are taken over by the editor, which is SUPER annoying
 *     https://github.com/ajaxorg/ace/issues/210
 */
/*
 * JavaScript for WikiEditor Table of Contents
 */

$( document ).ready( function () {
	var $wpTextbox1 = $( '#wpTextbox1' );

	// Code is supposed to be always LTR. See bug 39364.
	$wpTextbox1.parent().prop( 'dir', 'ltr' );

	// Add code editor module
	$wpTextbox1.wikiEditor( 'addModule', 'codeEditor' );

	$wpTextbox1.on( 'wikiEditor-toolbar-doneInitialSections', function () {
		$wpTextbox1.data( 'wikiEditor-context' ).fn.codeEditorMonitorFragment();
	} );
} );
