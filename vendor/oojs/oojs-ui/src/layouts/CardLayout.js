/**
 * CardLayouts are used within {@link OO.ui.IndexLayout index layouts} to create cards that users can select and display
 * from the index's optional {@link OO.ui.TabSelectWidget tab} navigation. Cards are usually not instantiated directly,
 * rather extended to include the required content and functionality.
 *
 * Each card must have a unique symbolic name, which is passed to the constructor. In addition, the card's tab
 * item is customized (with a label) using the #setupTabItem method. See
 * {@link OO.ui.IndexLayout IndexLayout} for an example.
 *
 * @class
 * @extends OO.ui.PanelLayout
 *
 * @constructor
 * @param {string} name Unique symbolic name of card
 * @param {Object} [config] Configuration options
 */
OO.ui.CardLayout = function OoUiCardLayout( name, config ) {
	// Allow passing positional parameters inside the config object
	if ( OO.isPlainObject( name ) && config === undefined ) {
		config = name;
		name = config.name;
	}

	// Configuration initialization
	config = $.extend( { scrollable: true }, config );

	// Parent constructor
	OO.ui.CardLayout.super.call( this, config );

	// Properties
	this.name = name;
	this.tabItem = null;
	this.active = false;

	// Initialization
	this.$element.addClass( 'oo-ui-cardLayout' );
};

/* Setup */

OO.inheritClass( OO.ui.CardLayout, OO.ui.PanelLayout );

/* Events */

/**
 * An 'active' event is emitted when the card becomes active. Cards become active when they are
 * shown in a index layout that is configured to display only one card at a time.
 *
 * @event active
 * @param {boolean} active Card is active
 */

/* Methods */

/**
 * Get the symbolic name of the card.
 *
 * @return {string} Symbolic name of card
 */
OO.ui.CardLayout.prototype.getName = function () {
	return this.name;
};

/**
 * Check if card is active.
 *
 * Cards become active when they are shown in a {@link OO.ui.IndexLayout index layout} that is configured to display
 * only one card at a time. Additional CSS is applied to the card's tab item to reflect the active state.
 *
 * @return {boolean} Card is active
 */
OO.ui.CardLayout.prototype.isActive = function () {
	return this.active;
};

/**
 * Get tab item.
 *
 * The tab item allows users to access the card from the index's tab
 * navigation. The tab item itself can be customized (with a label, level, etc.) using the #setupTabItem method.
 *
 * @return {OO.ui.TabOptionWidget|null} Tab option widget
 */
OO.ui.CardLayout.prototype.getTabItem = function () {
	return this.tabItem;
};

/**
 * Set or unset the tab item.
 *
 * Specify a {@link OO.ui.TabOptionWidget tab option} to set it,
 * or `null` to clear the tab item. To customize the tab item itself (e.g., to set a label or tab
 * level), use #setupTabItem instead of this method.
 *
 * @param {OO.ui.TabOptionWidget|null} tabItem Tab option widget, null to clear
 * @chainable
 */
OO.ui.CardLayout.prototype.setTabItem = function ( tabItem ) {
	this.tabItem = tabItem || null;
	if ( tabItem ) {
		this.setupTabItem();
	}
	return this;
};

/**
 * Set up the tab item.
 *
 * Use this method to customize the tab item (e.g., to add a label or tab level). To set or unset
 * the tab item itself (with a {@link OO.ui.TabOptionWidget tab option} or `null`), use
 * the #setTabItem method instead.
 *
 * @param {OO.ui.TabOptionWidget} tabItem Tab option widget to set up
 * @chainable
 */
OO.ui.CardLayout.prototype.setupTabItem = function () {
	return this;
};

/**
 * Set the card to its 'active' state.
 *
 * Cards become active when they are shown in a index layout that is configured to display only one card at a time. Additional
 * CSS is applied to the tab item to reflect the card's active state. Outside of the index
 * context, setting the active state on a card does nothing.
 *
 * @param {boolean} value Card is active
 * @fires active
 */
OO.ui.CardLayout.prototype.setActive = function ( active ) {
	active = !!active;

	if ( active !== this.active ) {
		this.active = active;
		this.$element.toggleClass( 'oo-ui-cardLayout-active', this.active );
		this.emit( 'active', this.active );
	}
};
