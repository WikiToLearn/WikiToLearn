/**
 * @class
 * @extends {OO.ui.Theme}
 *
 * @constructor
 */
OO.ui.BlankTheme = function OoUiBlankTheme() {
	// Parent constructor
	OO.ui.BlankTheme.super.call( this );
};

/* Setup */

OO.inheritClass( OO.ui.BlankTheme, OO.ui.Theme );

/* Methods */

/**
 * @inheritdoc
 */
OO.ui.BlankTheme.prototype.getElementClasses = function ( element ) {
	// Parent method
	var classes = OO.ui.BlankTheme.super.prototype.getElementClasses.call( this, element );

	// Add classes to classes.on or classes.off

	return classes;
};

/* Instantiation */

OO.ui.theme = new OO.ui.BlankTheme();
