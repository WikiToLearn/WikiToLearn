// Demonstrate JavaScript 'infusion' of PHP-generated widgets.
// Used by widgets.php.

var $menu, themeButtons, themes;

// Helper function to get high resolution profiling data, where available.
function now() {
	/* global performance */
	return ( typeof performance !== 'undefined' ) ? performance.now() :
		Date.now ? Date.now() : new Date().getTime();
}

// Add a button to infuse everything!
// (You wouldn't typically do this: you'd only infuse those objects which
//  you needed to attach client-side behaviors to.  But our theme-setting
//  code needs a list of all widgets, and it's a good overall test.)
function infuseAll() {
	var start, end, all;
	start = now();
	all = $( '*[data-ooui]' ).map( function ( _, e ) {
		return OO.ui.infuse( e.id );
	} );
	end = now();
	window.console.log( 'Infusion time: ' + ( end - start ) );
	return all;
}
$menu = $( '.oo-ui-demo-menu' );
$menu.append(
	new OO.ui.ButtonGroupWidget().addItems( [
		new OO.ui.ButtonWidget( { label: 'Infuse' } )
			.on( 'click', infuseAll )
	] ).$element );

// Hook up the theme switch buttons.
// This is more like a typical use case: we are just infusing specific
// named UI elements.
themeButtons = [
	// If you're lazy, you can just use OO.ui.infuse.  But if you name the
	// Element type you're expecting, you can get some type checking.
	OO.ui.ButtonWidget.static.infuse( 'theme-mediawiki' ),
	OO.ui.ButtonWidget.static.infuse( 'theme-apex' )
];
themes = {
	mediawiki: new OO.ui.MediaWikiTheme(),
	apex: new OO.ui.ApexTheme()
};
function updateTheme( theme ) {
	OO.ui.theme = themes[theme];
	$.each( infuseAll(), function ( _, el ) {
		// FIXME: this isn't really supported, but it makes a neat demo.
		OO.ui.theme.updateElementClasses( el );
	} );
	// A bit of a hack, but it will do for a demo.
	$( 'link[rel="stylesheet"][title="theme"]' ).attr(
		'href',
		'../dist/oojs-ui-' + theme + '.vector.css'
	);
}
// This is another more typical usage: we take the existing server-side
// buttons and replace the href with a JS click handler.
$.each( themeButtons, function ( _, b ) {
	// Get rid of the old server-side click handling.
	b.setHref( null );
	// Add new client-side click handling.
	b.on( 'click', function () { updateTheme( b.getData() ); } );
} );
