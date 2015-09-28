/**
 * Mixin for OO.ui.Widget subclasses to provide OO.ui.GroupElement.
 *
 * Use together with OO.ui.ItemWidget to make disabled state inheritable.
 *
 * @private
 * @abstract
 * @class
 * @extends OO.ui.GroupElement
 *
 * @constructor
 * @param {Object} [config] Configuration options
 */
OO.ui.GroupWidget = function OoUiGroupWidget( config ) {
	// Parent constructor
	OO.ui.GroupWidget.super.call( this, config );
};

/* Setup */

OO.inheritClass( OO.ui.GroupWidget, OO.ui.GroupElement );

/* Methods */

/**
 * Set the disabled state of the widget.
 *
 * This will also update the disabled state of child widgets.
 *
 * @param {boolean} disabled Disable widget
 * @chainable
 */
OO.ui.GroupWidget.prototype.setDisabled = function ( disabled ) {
	var i, len;

	// Parent method
	// Note: Calling #setDisabled this way assumes this is mixed into an OO.ui.Widget
	OO.ui.Widget.prototype.setDisabled.call( this, disabled );

	// During construction, #setDisabled is called before the OO.ui.GroupElement constructor
	if ( this.items ) {
		for ( i = 0, len = this.items.length; i < len; i++ ) {
			this.items[ i ].updateDisabled();
		}
	}

	return this;
};
