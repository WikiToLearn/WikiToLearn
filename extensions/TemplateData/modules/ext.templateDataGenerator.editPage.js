( function () {
	/*!
	 * TemplateData Generator button fixture
	 * The button will appear on Template namespaces only, above the edit textbox
	 *
	 * @author Moriel Schottlender
	 */
	'use strict';

	$( function () {
		var pieces, isDocPage,
			pageName = mw.config.get( 'wgPageName' ),
			config = {
				pageName: pageName,
				isPageSubLevel: false
			},
			$textbox = $( '#wpTextbox1' );

		// Check if there's an editor textarea and if we're in the proper namespace
		if ( $textbox.length && mw.config.get( 'wgCanonicalNamespace' ) === 'Template' ) {
			pieces = pageName.split( '/' );
			isDocPage = pieces.length > 1 && pieces[ pieces.length - 1 ] === 'doc';

			config = {
				pageName: pageName,
				isPageSubLevel: pieces.length > 1,
				parentPage: pageName,
				isDocPage: isDocPage
			};

			// Only if we are in a doc page do we set the parent page to
			// the one above. Otherwise, all parent pages are current pages
			if ( isDocPage ) {
				pieces.pop();
				config.parentPage = pieces.join( '/' );
			}
			// Prepare the editor
			mw.libs.tdgUi.init( $( '#mw-content-text' ), $textbox, config );
		}

	} );

}() );
