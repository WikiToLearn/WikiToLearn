/**
 * IndexLayouts contain {@link OO.ui.CardLayout card layouts} as well as
 * {@link OO.ui.TabSelectWidget tabs} that allow users to easily navigate through the cards and
 * select which one to display. By default, only one card is displayed at a time. When a user
 * navigates to a new card, the index layout automatically focuses on the first focusable element,
 * unless the default setting is changed.
 *
 * TODO: This class is similar to BookletLayout, we may want to refactor to reduce duplication
 *
 *     @example
 *     // Example of a IndexLayout that contains two CardLayouts.
 *
 *     function CardOneLayout( name, config ) {
 *         CardOneLayout.super.call( this, name, config );
 *         this.$element.append( '<p>First card</p>' );
 *     }
 *     OO.inheritClass( CardOneLayout, OO.ui.CardLayout );
 *     CardOneLayout.prototype.setupTabItem = function () {
 *         this.tabItem.setLabel( 'Card One' );
 *     };
 *
 *     function CardTwoLayout( name, config ) {
 *         CardTwoLayout.super.call( this, name, config );
 *         this.$element.append( '<p>Second card</p>' );
 *     }
 *     OO.inheritClass( CardTwoLayout, OO.ui.CardLayout );
 *     CardTwoLayout.prototype.setupTabItem = function () {
 *         this.tabItem.setLabel( 'Card Two' );
 *     };
 *
 *     var card1 = new CardOneLayout( 'one' ),
 *         card2 = new CardTwoLayout( 'two' );
 *
 *     var index = new OO.ui.IndexLayout();
 *
 *     index.addCards ( [ card1, card2 ] );
 *     $( 'body' ).append( index.$element );
 *
 * @class
 * @extends OO.ui.MenuLayout
 *
 * @constructor
 * @param {Object} [config] Configuration options
 * @cfg {boolean} [continuous=false] Show all cards, one after another
 * @cfg {boolean} [autoFocus=true] Focus on the first focusable element when a new card is displayed.
 */
OO.ui.IndexLayout = function OoUiIndexLayout( config ) {
	// Configuration initialization
	config = $.extend( {}, config, { menuPosition: 'top' } );

	// Parent constructor
	OO.ui.IndexLayout.super.call( this, config );

	// Properties
	this.currentCardName = null;
	this.cards = {};
	this.ignoreFocus = false;
	this.stackLayout = new OO.ui.StackLayout( { continuous: !!config.continuous } );
	this.$content.append( this.stackLayout.$element );
	this.autoFocus = config.autoFocus === undefined || !!config.autoFocus;

	this.tabSelectWidget = new OO.ui.TabSelectWidget();
	this.tabPanel = new OO.ui.PanelLayout();
	this.$menu.append( this.tabPanel.$element );

	this.toggleMenu( true );

	// Events
	this.stackLayout.connect( this, { set: 'onStackLayoutSet' } );
	this.tabSelectWidget.connect( this, { select: 'onTabSelectWidgetSelect' } );
	if ( this.autoFocus ) {
		// Event 'focus' does not bubble, but 'focusin' does
		this.stackLayout.$element.on( 'focusin', this.onStackLayoutFocus.bind( this ) );
	}

	// Initialization
	this.$element.addClass( 'oo-ui-indexLayout' );
	this.stackLayout.$element.addClass( 'oo-ui-indexLayout-stackLayout' );
	this.tabPanel.$element
		.addClass( 'oo-ui-indexLayout-tabPanel' )
		.append( this.tabSelectWidget.$element );
};

/* Setup */

OO.inheritClass( OO.ui.IndexLayout, OO.ui.MenuLayout );

/* Events */

/**
 * A 'set' event is emitted when a card is {@link #setCard set} to be displayed by the index layout.
 * @event set
 * @param {OO.ui.CardLayout} card Current card
 */

/**
 * An 'add' event is emitted when cards are {@link #addCards added} to the index layout.
 *
 * @event add
 * @param {OO.ui.CardLayout[]} card Added cards
 * @param {number} index Index cards were added at
 */

/**
 * A 'remove' event is emitted when cards are {@link #clearCards cleared} or
 * {@link #removeCards removed} from the index.
 *
 * @event remove
 * @param {OO.ui.CardLayout[]} cards Removed cards
 */

/* Methods */

/**
 * Handle stack layout focus.
 *
 * @private
 * @param {jQuery.Event} e Focusin event
 */
OO.ui.IndexLayout.prototype.onStackLayoutFocus = function ( e ) {
	var name, $target;

	// Find the card that an element was focused within
	$target = $( e.target ).closest( '.oo-ui-cardLayout' );
	for ( name in this.cards ) {
		// Check for card match, exclude current card to find only card changes
		if ( this.cards[ name ].$element[ 0 ] === $target[ 0 ] && name !== this.currentCardName ) {
			this.setCard( name );
			break;
		}
	}
};

/**
 * Handle stack layout set events.
 *
 * @private
 * @param {OO.ui.PanelLayout|null} card The card panel that is now the current panel
 */
OO.ui.IndexLayout.prototype.onStackLayoutSet = function ( card ) {
	var layout = this;
	if ( card ) {
		card.scrollElementIntoView( { complete: function () {
			if ( layout.autoFocus ) {
				layout.focus();
			}
		} } );
	}
};

/**
 * Focus the first input in the current card.
 *
 * If no card is selected, the first selectable card will be selected.
 * If the focus is already in an element on the current card, nothing will happen.
 * @param {number} [itemIndex] A specific item to focus on
 */
OO.ui.IndexLayout.prototype.focus = function ( itemIndex ) {
	var $input, card,
		items = this.stackLayout.getItems();

	if ( itemIndex !== undefined && items[ itemIndex ] ) {
		card = items[ itemIndex ];
	} else {
		card = this.stackLayout.getCurrentItem();
	}

	if ( !card ) {
		this.selectFirstSelectableCard();
		card = this.stackLayout.getCurrentItem();
	}
	if ( !card ) {
		return;
	}
	// Only change the focus if is not already in the current card
	if ( !card.$element.find( ':focus' ).length ) {
		$input = card.$element.find( ':input:first' );
		if ( $input.length ) {
			$input[ 0 ].focus();
		}
	}
};

/**
 * Find the first focusable input in the index layout and focus
 * on it.
 */
OO.ui.IndexLayout.prototype.focusFirstFocusable = function () {
	var i, len,
		found = false,
		items = this.stackLayout.getItems(),
		checkAndFocus = function () {
			if ( OO.ui.isFocusableElement( $( this ) ) ) {
				$( this ).focus();
				found = true;
				return false;
			}
		};

	for ( i = 0, len = items.length; i < len; i++ ) {
		if ( found ) {
			break;
		}
		// Find all potentially focusable elements in the item
		// and check if they are focusable
		items[i].$element
			.find( 'input, select, textarea, button, object' )
			.each( checkAndFocus );
	}
};

/**
 * Handle tab widget select events.
 *
 * @private
 * @param {OO.ui.OptionWidget|null} item Selected item
 */
OO.ui.IndexLayout.prototype.onTabSelectWidgetSelect = function ( item ) {
	if ( item ) {
		this.setCard( item.getData() );
	}
};

/**
 * Get the card closest to the specified card.
 *
 * @param {OO.ui.CardLayout} card Card to use as a reference point
 * @return {OO.ui.CardLayout|null} Card closest to the specified card
 */
OO.ui.IndexLayout.prototype.getClosestCard = function ( card ) {
	var next, prev, level,
		cards = this.stackLayout.getItems(),
		index = $.inArray( card, cards );

	if ( index !== -1 ) {
		next = cards[ index + 1 ];
		prev = cards[ index - 1 ];
		// Prefer adjacent cards at the same level
		level = this.tabSelectWidget.getItemFromData( card.getName() ).getLevel();
		if (
			prev &&
			level === this.tabSelectWidget.getItemFromData( prev.getName() ).getLevel()
		) {
			return prev;
		}
		if (
			next &&
			level === this.tabSelectWidget.getItemFromData( next.getName() ).getLevel()
		) {
			return next;
		}
	}
	return prev || next || null;
};

/**
 * Get the tabs widget.
 *
 * @return {OO.ui.TabSelectWidget} Tabs widget
 */
OO.ui.IndexLayout.prototype.getTabs = function () {
	return this.tabSelectWidget;
};

/**
 * Get a card by its symbolic name.
 *
 * @param {string} name Symbolic name of card
 * @return {OO.ui.CardLayout|undefined} Card, if found
 */
OO.ui.IndexLayout.prototype.getCard = function ( name ) {
	return this.cards[ name ];
};

/**
 * Get the current card.
 *
 * @return {OO.ui.CardLayout|undefined} Current card, if found
 */
OO.ui.IndexLayout.prototype.getCurrentCard = function () {
	var name = this.getCurrentCardName();
	return name ? this.getCard( name ) : undefined;
};

/**
 * Get the symbolic name of the current card.
 *
 * @return {string|null} Symbolic name of the current card
 */
OO.ui.IndexLayout.prototype.getCurrentCardName = function () {
	return this.currentCardName;
};

/**
 * Add cards to the index layout
 *
 * When cards are added with the same names as existing cards, the existing cards will be
 * automatically removed before the new cards are added.
 *
 * @param {OO.ui.CardLayout[]} cards Cards to add
 * @param {number} index Index of the insertion point
 * @fires add
 * @chainable
 */
OO.ui.IndexLayout.prototype.addCards = function ( cards, index ) {
	var i, len, name, card, item, currentIndex,
		stackLayoutCards = this.stackLayout.getItems(),
		remove = [],
		items = [];

	// Remove cards with same names
	for ( i = 0, len = cards.length; i < len; i++ ) {
		card = cards[ i ];
		name = card.getName();

		if ( Object.prototype.hasOwnProperty.call( this.cards, name ) ) {
			// Correct the insertion index
			currentIndex = $.inArray( this.cards[ name ], stackLayoutCards );
			if ( currentIndex !== -1 && currentIndex + 1 < index ) {
				index--;
			}
			remove.push( this.cards[ name ] );
		}
	}
	if ( remove.length ) {
		this.removeCards( remove );
	}

	// Add new cards
	for ( i = 0, len = cards.length; i < len; i++ ) {
		card = cards[ i ];
		name = card.getName();
		this.cards[ card.getName() ] = card;
		item = new OO.ui.TabOptionWidget( { data: name } );
		card.setTabItem( item );
		items.push( item );
	}

	if ( items.length ) {
		this.tabSelectWidget.addItems( items, index );
		this.selectFirstSelectableCard();
	}
	this.stackLayout.addItems( cards, index );
	this.emit( 'add', cards, index );

	return this;
};

/**
 * Remove the specified cards from the index layout.
 *
 * To remove all cards from the index, you may wish to use the #clearCards method instead.
 *
 * @param {OO.ui.CardLayout[]} cards An array of cards to remove
 * @fires remove
 * @chainable
 */
OO.ui.IndexLayout.prototype.removeCards = function ( cards ) {
	var i, len, name, card,
		items = [];

	for ( i = 0, len = cards.length; i < len; i++ ) {
		card = cards[ i ];
		name = card.getName();
		delete this.cards[ name ];
		items.push( this.tabSelectWidget.getItemFromData( name ) );
		card.setTabItem( null );
	}
	if ( items.length ) {
		this.tabSelectWidget.removeItems( items );
		this.selectFirstSelectableCard();
	}
	this.stackLayout.removeItems( cards );
	this.emit( 'remove', cards );

	return this;
};

/**
 * Clear all cards from the index layout.
 *
 * To remove only a subset of cards from the index, use the #removeCards method.
 *
 * @fires remove
 * @chainable
 */
OO.ui.IndexLayout.prototype.clearCards = function () {
	var i, len,
		cards = this.stackLayout.getItems();

	this.cards = {};
	this.currentCardName = null;
	this.tabSelectWidget.clearItems();
	for ( i = 0, len = cards.length; i < len; i++ ) {
		cards[ i ].setTabItem( null );
	}
	this.stackLayout.clearItems();

	this.emit( 'remove', cards );

	return this;
};

/**
 * Set the current card by symbolic name.
 *
 * @fires set
 * @param {string} name Symbolic name of card
 */
OO.ui.IndexLayout.prototype.setCard = function ( name ) {
	var selectedItem,
		$focused,
		card = this.cards[ name ];

	if ( name !== this.currentCardName ) {
		selectedItem = this.tabSelectWidget.getSelectedItem();
		if ( selectedItem && selectedItem.getData() !== name ) {
			this.tabSelectWidget.selectItemByData( name );
		}
		if ( card ) {
			if ( this.currentCardName && this.cards[ this.currentCardName ] ) {
				this.cards[ this.currentCardName ].setActive( false );
				// Blur anything focused if the next card doesn't have anything focusable - this
				// is not needed if the next card has something focusable because once it is focused
				// this blur happens automatically
				if ( this.autoFocus && !card.$element.find( ':input' ).length ) {
					$focused = this.cards[ this.currentCardName ].$element.find( ':focus' );
					if ( $focused.length ) {
						$focused[ 0 ].blur();
					}
				}
			}
			this.currentCardName = name;
			this.stackLayout.setItem( card );
			card.setActive( true );
			this.emit( 'set', card );
		}
	}
};

/**
 * Select the first selectable card.
 *
 * @chainable
 */
OO.ui.IndexLayout.prototype.selectFirstSelectableCard = function () {
	if ( !this.tabSelectWidget.getSelectedItem() ) {
		this.tabSelectWidget.selectItem( this.tabSelectWidget.getFirstSelectableItem() );
	}

	return this;
};
