/**
 * This is experimental and does not yet actually save anything back.
 * Has to be manually enabled.
 * Needs some code de-dup with the full-page JS/CSS page editing.
 */
/*global ace */
( function ( $, mw ) {

$( function () {
	var $sources, setupEditor, openEditor;

	$sources = $( '.mw-geshi' );

	if ( $sources.length > 0 ) {
		setupEditor = function ( $div ) {
			var $link, $edit;

			$link = $( '<a>' )
				.text( mw.msg( 'editsection' ) )
				.attr( 'href', '#' )
				.attr( 'title', 'Edit this code section' )
				.click( function ( event ) {
					openEditor( $div );
					event.preventDefault();
				} );
			$edit = $( '<span>' )
				.addClass( 'mw-editsection' )
				.append( '<span class="mw-editsection-bracket">[</span>' )
				.append( $link )
				.append( '<span class="mw-editsection-bracket">]</span>' );
			$div.prepend( $edit );
		};

		openEditor = function ( $div ) {
			var $main, geshiLang, matches, $label, $langDropDown, $xcontainer, codeEditor;

			$main = $div.find( 'div' );
			geshiLang = null;
			matches = /(?:^| )source-([a-z0-9_-]+)/.exec( $main.attr( 'class' ) );

			if ( matches ) {
				geshiLang = matches[ 1 ];
			}
			mw.loader.using( 'ext.codeEditor.ace.modes', function () {
				var map, $container, $save, $cancel, $controls, setLanguage, closeEditor;

				// @fixme de-duplicate
				map = {
					c: 'c_cpp',
					cpp: 'c_cpp',
					clojure: 'clojure',
					csharp: 'csharp',
					css: 'css',
					coffeescript: 'coffee',
					groovy: 'groovy',
					html4strict: 'html',
					html5: 'html',
					java: 'java',
					java5: 'java',
					javascript: 'javascript',
					jquery: 'javascript',
					json: 'json',
					ocaml: 'ocaml',
					perl: 'perl',
					php: 'php',
					python: 'python',
					ruby: 'ruby',
					scala: 'scala',
					xml: 'xml'
				};

				$container = $( '<div>' )
					.attr( 'style', 'top: 32px; left: 0px; right: 0px; bottom: 0px; border: 1px solid gray; position: absolute;' )
					.text( $main.text() ); // quick hack :D

				$label = $( '<label>' ).text( 'Source language: ' );
				$langDropDown = $( '<select>' );
				$.each( map, function ( geshiLang ) {
					$( '<option>' )
						.text( geshiLang )
						.val( geshiLang )
						.appendTo( $langDropDown );
				} );
				$langDropDown
					.val( geshiLang )
					.appendTo( $label )
					.change( function () {
						setLanguage( $( this ).val() );
					} );
				$save = $( '<button>' )
					.text( mw.msg( 'savearticle' ) )
					.click( function ( event ) {
						// horrible hack ;)
						var src, tag, api = new mw.Api();

						src = codeEditor.getSession().getValue();
						tag = '<source lang="' + geshiLang + '">' + src + '</source>';

						api.parse( tag )
						.done( function ( html ) {
							var $html = $( html );
							$div.replaceWith( $html );
							setupEditor( $html );

							closeEditor();
						} );
						event.preventDefault();
					} );
				$cancel = $( '<button>' )
					.text( 'Close' ).click( function ( event ) {
						$xcontainer.remove();
						$div.show();
						event.preventDefault();
					} );
				$controls = $( '<div>' )
					.append( $label )
					.append( $save )
					.append( $cancel );
				$xcontainer = $( '<div style="position: relative"></div>' )
					.append( $controls )
					.append( $container );
				$xcontainer.width( $main.width() )
					.height( $main.height() * 1.1 + 64 + 32 );

				$div.hide();
				$xcontainer.insertAfter( $div );

				codeEditor = ace.edit( $container[ 0 ] );

				setLanguage = function ( lang ) {
					var aceLang = map[ lang ],
						AceLangMode = ace.require( 'ace/mode/' + aceLang ).Mode;
					geshiLang = lang;
					codeEditor.getSession().setMode( new AceLangMode() );
				};
				setLanguage( geshiLang );

				// Remove some annoying commands
				codeEditor.commands.removeCommand( 'replace' );          // ctrl+R
				codeEditor.commands.removeCommand( 'transposeletters' ); // ctrl+T
				codeEditor.commands.removeCommand( 'gotoline' );         // ctrl+L

				closeEditor = function () {
					$xcontainer.remove();
					$div.show();
				};
			} );
		};

		$sources.each( function () {
			setupEditor( $( this ) );
		} );
	}
} );
}( jQuery, mediaWiki ) );
