/**
 * IconWidget is a generic widget for {@link OO.ui.IconElement icons}. In general, IconWidgets should be used with OO.ui.LabelWidget,
 * which creates a label that identifies the icon’s function. See the [OOjs UI documentation on MediaWiki] [1]
 * for a list of icons included in the library.
 *
 *     @example
 *     // An icon widget with a label
 *     var myIcon = new OO.ui.IconWidget( {
 *         icon: 'help',
 *         iconTitle: 'Help'
 *      } );
 *      // Create a label.
 *      var iconLabel = new OO.ui.LabelWidget( {
 *          label: 'Help'
 *      } );
 *      $( 'body' ).append( myIcon.$element, iconLabel.$element );
 *
 * [1]: https://www.mediawiki.org/wiki/OOjs_UI/Widgets/Icons,_Indicators,_and_Labels#Icons
 *
 * @class
 * @extends OO.ui.Widget
 * @mixins OO.ui.IconElement
 * @mixins OO.ui.TitledElement
 * @mixins OO.ui.FlaggedElement
 *
 * @constructor
 * @param {Object} [config] Configuration options
 */
OO.ui.IconWidget = function OoUiIconWidget( config ) {
	// Configuration initialization
	config = config || {};

	// Parent constructor
	OO.ui.IconWidget.super.call( this, config );

	// Mixin constructors
	OO.ui.IconElement.call( this, $.extend( {}, config, { $icon: this.$element } ) );
	OO.ui.TitledElement.call( this, $.extend( {}, config, { $titled: this.$element } ) );
	OO.ui.FlaggedElement.call( this, $.extend( {}, config, { $flagged: this.$element } ) );

	// Initialization
	this.$element.addClass( 'oo-ui-iconWidget' );
};

/* Setup */

OO.inheritClass( OO.ui.IconWidget, OO.ui.Widget );
OO.mixinClass( OO.ui.IconWidget, OO.ui.IconElement );
OO.mixinClass( OO.ui.IconWidget, OO.ui.TitledElement );
OO.mixinClass( OO.ui.IconWidget, OO.ui.FlaggedElement );

/* Static Properties */

OO.ui.IconWidget.static.tagName = 'span';
