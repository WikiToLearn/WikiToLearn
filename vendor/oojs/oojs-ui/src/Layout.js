/**
 * Layouts are containers for elements and are used to arrange other widgets of arbitrary type in a way
 * that is centrally controlled and can be updated dynamically. Layouts can be, and usually are, combined.
 * See {@link OO.ui.FieldsetLayout FieldsetLayout}, {@link OO.ui.FieldLayout FieldLayout}, {@link OO.ui.FormLayout FormLayout},
 * {@link OO.ui.PanelLayout PanelLayout}, {@link OO.ui.StackLayout StackLayout}, {@link OO.ui.PageLayout PageLayout},
 * and {@link OO.ui.BookletLayout BookletLayout} for more information and examples.
 *
 * @abstract
 * @class
 * @extends OO.ui.Element
 * @mixins OO.EventEmitter
 *
 * @constructor
 * @param {Object} [config] Configuration options
 */
OO.ui.Layout = function OoUiLayout( config ) {
	// Configuration initialization
	config = config || {};

	// Parent constructor
	OO.ui.Layout.super.call( this, config );

	// Mixin constructors
	OO.EventEmitter.call( this );

	// Initialization
	this.$element.addClass( 'oo-ui-layout' );
};

/* Setup */

OO.inheritClass( OO.ui.Layout, OO.ui.Element );
OO.mixinClass( OO.ui.Layout, OO.EventEmitter );
