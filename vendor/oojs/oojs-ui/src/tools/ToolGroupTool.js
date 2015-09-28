/**
 * Tool that has a tool group inside. This is a bad workaround for the lack of proper hierarchical
 * menus in toolbars (T74159).
 *
 * @abstract
 * @class
 * @extends OO.ui.Tool
 *
 * @constructor
 * @param {OO.ui.ToolGroup} toolGroup
 * @param {Object} [config] Configuration options
 */
OO.ui.ToolGroupTool = function OoUiToolGroupTool( toolGroup, config ) {
	// Allow passing positional parameters inside the config object
	if ( OO.isPlainObject( toolGroup ) && config === undefined ) {
		config = toolGroup;
		toolGroup = config.toolGroup;
	}

	// Parent constructor
	OO.ui.ToolGroupTool.super.call( this, toolGroup, config );

	// Properties
	this.innerToolGroup = this.createGroup( this.constructor.static.groupConfig );

	// Events
	this.innerToolGroup.connect( this, { disable: 'onToolGroupDisable' } );

	// Initialization
	this.$link.remove();
	this.$element
		.addClass( 'oo-ui-toolGroupTool' )
		.append( this.innerToolGroup.$element );
};

/* Setup */

OO.inheritClass( OO.ui.ToolGroupTool, OO.ui.Tool );

/* Static Properties */

/**
 * Tool group configuration. See OO.ui.Toolbar#setup for the accepted values.
 *
 * @property {Object.<string,Array>}
 */
OO.ui.ToolGroupTool.static.groupConfig = {};

/* Methods */

/**
 * Handle the tool being selected.
 *
 * @inheritdoc
 */
OO.ui.ToolGroupTool.prototype.onSelect = function () {
	this.innerToolGroup.setActive( !this.innerToolGroup.active );
	return false;
};

/**
 * Synchronize disabledness state of the tool with the inner toolgroup.
 *
 * @private
 * @param {boolean} disabled Element is disabled
 */
OO.ui.ToolGroupTool.prototype.onToolGroupDisable = function ( disabled ) {
	this.setDisabled( disabled );
};

/**
 * Handle the toolbar state being updated.
 *
 * @inheritdoc
 */
OO.ui.ToolGroupTool.prototype.onUpdateState = function () {
	this.setActive( false );
};

/**
 * Build a OO.ui.ToolGroup from the configuration.
 *
 * @param {Object.<string,Array>} group Tool group configuration. See OO.ui.Toolbar#setup for the
 *   accepted values.
 * @return {OO.ui.ListToolGroup}
 */
OO.ui.ToolGroupTool.prototype.createGroup = function ( group ) {
	if ( group.include === '*' ) {
		// Apply defaults to catch-all groups
		if ( group.label === undefined ) {
			group.label = OO.ui.msg( 'ooui-toolbar-more' );
		}
	}

	return this.toolbar.getToolGroupFactory().create( 'list', this.toolbar, group );
};
