/**
 * TextInputMenuSelectWidget is a menu that is specially designed to be positioned beneath
 * a {@link OO.ui.TextInputWidget text input} field. The menu's position is automatically
 * calculated and maintained when the menu is toggled or the window is resized.
 * See OO.ui.ComboBoxWidget for an example of a widget that uses this class.
 *
 * @class
 * @extends OO.ui.MenuSelectWidget
 *
 * @constructor
 * @param {OO.ui.TextInputWidget} inputWidget Text input widget to provide menu for
 * @param {Object} [config] Configuration options
 * @cfg {jQuery} [$container=input.$element] Element to render menu under
 */
OO.ui.TextInputMenuSelectWidget = function OoUiTextInputMenuSelectWidget( inputWidget, config ) {
	// Allow passing positional parameters inside the config object
	if ( OO.isPlainObject( inputWidget ) && config === undefined ) {
		config = inputWidget;
		inputWidget = config.inputWidget;
	}

	// Configuration initialization
	config = config || {};

	// Parent constructor
	OO.ui.TextInputMenuSelectWidget.super.call( this, config );

	// Properties
	this.inputWidget = inputWidget;
	this.$container = config.$container || this.inputWidget.$element;
	this.onWindowResizeHandler = this.onWindowResize.bind( this );

	// Initialization
	this.$element.addClass( 'oo-ui-textInputMenuSelectWidget' );
};

/* Setup */

OO.inheritClass( OO.ui.TextInputMenuSelectWidget, OO.ui.MenuSelectWidget );

/* Methods */

/**
 * Handle window resize event.
 *
 * @private
 * @param {jQuery.Event} e Window resize event
 */
OO.ui.TextInputMenuSelectWidget.prototype.onWindowResize = function () {
	this.position();
};

/**
 * @inheritdoc
 */
OO.ui.TextInputMenuSelectWidget.prototype.toggle = function ( visible ) {
	visible = visible === undefined ? !this.isVisible() : !!visible;

	var change = visible !== this.isVisible();

	if ( change && visible ) {
		// Make sure the width is set before the parent method runs.
		// After this we have to call this.position(); again to actually
		// position ourselves correctly.
		this.position();
	}

	// Parent method
	OO.ui.TextInputMenuSelectWidget.super.prototype.toggle.call( this, visible );

	if ( change ) {
		if ( this.isVisible() ) {
			this.position();
			$( this.getElementWindow() ).on( 'resize', this.onWindowResizeHandler );
		} else {
			$( this.getElementWindow() ).off( 'resize', this.onWindowResizeHandler );
		}
	}

	return this;
};

/**
 * Position the menu.
 *
 * @private
 * @chainable
 */
OO.ui.TextInputMenuSelectWidget.prototype.position = function () {
	var $container = this.$container,
		pos = OO.ui.Element.static.getRelativePosition( $container, this.$element.offsetParent() );

	// Position under input
	pos.top += $container.height();
	this.$element.css( pos );

	// Set width
	this.setIdealSize( $container.width() );
	// We updated the position, so re-evaluate the clipping state
	this.clip();

	return this;
};
