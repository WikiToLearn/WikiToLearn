/**
 * LookupElement is a mixin that creates a {@link OO.ui.TextInputMenuSelectWidget menu} of suggested values for
 * a {@link OO.ui.TextInputWidget text input widget}. Suggested values are based on the characters the user types
 * into the text input field and, in general, the menu is only displayed when the user types. If a suggested value is chosen
 * from the lookup menu, that value becomes the value of the input field.
 *
 * Note that a new menu of suggested items is displayed when a value is chosen from the lookup menu. If this is
 * not the desired behavior, disable lookup menus with the #setLookupsDisabled method, then set the value, then
 * re-enable lookups.
 *
 * See the [OOjs UI demos][1] for an example.
 *
 * [1]: https://tools.wmflabs.org/oojs-ui/oojs-ui/demos/index.html#widgets-apex-vector-ltr
 *
 * @class
 * @abstract
 *
 * @constructor
 * @param {Object} [config] Configuration options
 * @cfg {jQuery} [$overlay] Overlay for the lookup menu; defaults to relative positioning
 * @cfg {jQuery} [$container=this.$element] The container element. The lookup menu is rendered beneath the specified element.
 * @cfg {boolean} [allowSuggestionsWhenEmpty=false] Request and display a lookup menu when the text input is empty.
 *  By default, the lookup menu is not generated and displayed until the user begins to type.
 */
OO.ui.LookupElement = function OoUiLookupElement( config ) {
	// Configuration initialization
	config = config || {};

	// Properties
	this.$overlay = config.$overlay || this.$element;
	this.lookupMenu = new OO.ui.TextInputMenuSelectWidget( this, {
		widget: this,
		input: this,
		$container: config.$container
	} );

	this.allowSuggestionsWhenEmpty = config.allowSuggestionsWhenEmpty || false;

	this.lookupCache = {};
	this.lookupQuery = null;
	this.lookupRequest = null;
	this.lookupsDisabled = false;
	this.lookupInputFocused = false;

	// Events
	this.$input.on( {
		focus: this.onLookupInputFocus.bind( this ),
		blur: this.onLookupInputBlur.bind( this ),
		mousedown: this.onLookupInputMouseDown.bind( this )
	} );
	this.connect( this, { change: 'onLookupInputChange' } );
	this.lookupMenu.connect( this, {
		toggle: 'onLookupMenuToggle',
		choose: 'onLookupMenuItemChoose'
	} );

	// Initialization
	this.$element.addClass( 'oo-ui-lookupElement' );
	this.lookupMenu.$element.addClass( 'oo-ui-lookupElement-menu' );
	this.$overlay.append( this.lookupMenu.$element );
};

/* Methods */

/**
 * Handle input focus event.
 *
 * @protected
 * @param {jQuery.Event} e Input focus event
 */
OO.ui.LookupElement.prototype.onLookupInputFocus = function () {
	this.lookupInputFocused = true;
	this.populateLookupMenu();
};

/**
 * Handle input blur event.
 *
 * @protected
 * @param {jQuery.Event} e Input blur event
 */
OO.ui.LookupElement.prototype.onLookupInputBlur = function () {
	this.closeLookupMenu();
	this.lookupInputFocused = false;
};

/**
 * Handle input mouse down event.
 *
 * @protected
 * @param {jQuery.Event} e Input mouse down event
 */
OO.ui.LookupElement.prototype.onLookupInputMouseDown = function () {
	// Only open the menu if the input was already focused.
	// This way we allow the user to open the menu again after closing it with Esc
	// by clicking in the input. Opening (and populating) the menu when initially
	// clicking into the input is handled by the focus handler.
	if ( this.lookupInputFocused && !this.lookupMenu.isVisible() ) {
		this.populateLookupMenu();
	}
};

/**
 * Handle input change event.
 *
 * @protected
 * @param {string} value New input value
 */
OO.ui.LookupElement.prototype.onLookupInputChange = function () {
	if ( this.lookupInputFocused ) {
		this.populateLookupMenu();
	}
};

/**
 * Handle the lookup menu being shown/hidden.
 *
 * @protected
 * @param {boolean} visible Whether the lookup menu is now visible.
 */
OO.ui.LookupElement.prototype.onLookupMenuToggle = function ( visible ) {
	if ( !visible ) {
		// When the menu is hidden, abort any active request and clear the menu.
		// This has to be done here in addition to closeLookupMenu(), because
		// MenuSelectWidget will close itself when the user presses Esc.
		this.abortLookupRequest();
		this.lookupMenu.clearItems();
	}
};

/**
 * Handle menu item 'choose' event, updating the text input value to the value of the clicked item.
 *
 * @protected
 * @param {OO.ui.MenuOptionWidget} item Selected item
 */
OO.ui.LookupElement.prototype.onLookupMenuItemChoose = function ( item ) {
	this.setValue( item.getData() );
};

/**
 * Get lookup menu.
 *
 * @private
 * @return {OO.ui.TextInputMenuSelectWidget}
 */
OO.ui.LookupElement.prototype.getLookupMenu = function () {
	return this.lookupMenu;
};

/**
 * Disable or re-enable lookups.
 *
 * When lookups are disabled, calls to #populateLookupMenu will be ignored.
 *
 * @param {boolean} disabled Disable lookups
 */
OO.ui.LookupElement.prototype.setLookupsDisabled = function ( disabled ) {
	this.lookupsDisabled = !!disabled;
};

/**
 * Open the menu. If there are no entries in the menu, this does nothing.
 *
 * @private
 * @chainable
 */
OO.ui.LookupElement.prototype.openLookupMenu = function () {
	if ( !this.lookupMenu.isEmpty() ) {
		this.lookupMenu.toggle( true );
	}
	return this;
};

/**
 * Close the menu, empty it, and abort any pending request.
 *
 * @private
 * @chainable
 */
OO.ui.LookupElement.prototype.closeLookupMenu = function () {
	this.lookupMenu.toggle( false );
	this.abortLookupRequest();
	this.lookupMenu.clearItems();
	return this;
};

/**
 * Request menu items based on the input's current value, and when they arrive,
 * populate the menu with these items and show the menu.
 *
 * If lookups have been disabled with #setLookupsDisabled, this function does nothing.
 *
 * @private
 * @chainable
 */
OO.ui.LookupElement.prototype.populateLookupMenu = function () {
	var widget = this,
		value = this.getValue();

	if ( this.lookupsDisabled ) {
		return;
	}

	// If the input is empty, clear the menu, unless suggestions when empty are allowed.
	if ( !this.allowSuggestionsWhenEmpty && value === '' ) {
		this.closeLookupMenu();
	// Skip population if there is already a request pending for the current value
	} else if ( value !== this.lookupQuery ) {
		this.getLookupMenuItems()
			.done( function ( items ) {
				widget.lookupMenu.clearItems();
				if ( items.length ) {
					widget.lookupMenu
						.addItems( items )
						.toggle( true );
					widget.initializeLookupMenuSelection();
				} else {
					widget.lookupMenu.toggle( false );
				}
			} )
			.fail( function () {
				widget.lookupMenu.clearItems();
			} );
	}

	return this;
};

/**
 * Highlight the first selectable item in the menu.
 *
 * @private
 * @chainable
 */
OO.ui.LookupElement.prototype.initializeLookupMenuSelection = function () {
	if ( !this.lookupMenu.getSelectedItem() ) {
		this.lookupMenu.highlightItem( this.lookupMenu.getFirstSelectableItem() );
	}
};

/**
 * Get lookup menu items for the current query.
 *
 * @private
 * @return {jQuery.Promise} Promise object which will be passed menu items as the first argument of
 *   the done event. If the request was aborted to make way for a subsequent request, this promise
 *   will not be rejected: it will remain pending forever.
 */
OO.ui.LookupElement.prototype.getLookupMenuItems = function () {
	var widget = this,
		value = this.getValue(),
		deferred = $.Deferred(),
		ourRequest;

	this.abortLookupRequest();
	if ( Object.prototype.hasOwnProperty.call( this.lookupCache, value ) ) {
		deferred.resolve( this.getLookupMenuOptionsFromData( this.lookupCache[ value ] ) );
	} else {
		this.pushPending();
		this.lookupQuery = value;
		ourRequest = this.lookupRequest = this.getLookupRequest();
		ourRequest
			.always( function () {
				// We need to pop pending even if this is an old request, otherwise
				// the widget will remain pending forever.
				// TODO: this assumes that an aborted request will fail or succeed soon after
				// being aborted, or at least eventually. It would be nice if we could popPending()
				// at abort time, but only if we knew that we hadn't already called popPending()
				// for that request.
				widget.popPending();
			} )
			.done( function ( response ) {
				// If this is an old request (and aborting it somehow caused it to still succeed),
				// ignore its success completely
				if ( ourRequest === widget.lookupRequest ) {
					widget.lookupQuery = null;
					widget.lookupRequest = null;
					widget.lookupCache[ value ] = widget.getLookupCacheDataFromResponse( response );
					deferred.resolve( widget.getLookupMenuOptionsFromData( widget.lookupCache[ value ] ) );
				}
			} )
			.fail( function () {
				// If this is an old request (or a request failing because it's being aborted),
				// ignore its failure completely
				if ( ourRequest === widget.lookupRequest ) {
					widget.lookupQuery = null;
					widget.lookupRequest = null;
					deferred.reject();
				}
			} );
	}
	return deferred.promise();
};

/**
 * Abort the currently pending lookup request, if any.
 *
 * @private
 */
OO.ui.LookupElement.prototype.abortLookupRequest = function () {
	var oldRequest = this.lookupRequest;
	if ( oldRequest ) {
		// First unset this.lookupRequest to the fail handler will notice
		// that the request is no longer current
		this.lookupRequest = null;
		this.lookupQuery = null;
		oldRequest.abort();
	}
};

/**
 * Get a new request object of the current lookup query value.
 *
 * @protected
 * @abstract
 * @return {jQuery.Promise} jQuery AJAX object, or promise object with an .abort() method
 */
OO.ui.LookupElement.prototype.getLookupRequest = function () {
	// Stub, implemented in subclass
	return null;
};

/**
 * Pre-process data returned by the request from #getLookupRequest.
 *
 * The return value of this function will be cached, and any further queries for the given value
 * will use the cache rather than doing API requests.
 *
 * @protected
 * @abstract
 * @param {Mixed} response Response from server
 * @return {Mixed} Cached result data
 */
OO.ui.LookupElement.prototype.getLookupCacheDataFromResponse = function () {
	// Stub, implemented in subclass
	return [];
};

/**
 * Get a list of menu option widgets from the (possibly cached) data returned by
 * #getLookupCacheDataFromResponse.
 *
 * @protected
 * @abstract
 * @param {Mixed} data Cached result data, usually an array
 * @return {OO.ui.MenuOptionWidget[]} Menu items
 */
OO.ui.LookupElement.prototype.getLookupMenuOptionsFromData = function () {
	// Stub, implemented in subclass
	return [];
};
