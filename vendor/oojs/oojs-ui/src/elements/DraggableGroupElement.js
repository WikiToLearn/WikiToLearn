/**
 * DraggableGroupElement is a mixin class used to create a group element to
 * contain draggable elements, which are items that can be clicked and dragged by a mouse.
 * The class is used with OO.ui.DraggableElement.
 *
 * @abstract
 * @class
 * @mixins OO.ui.GroupElement
 *
 * @constructor
 * @param {Object} [config] Configuration options
 * @cfg {string} [orientation] Item orientation: 'horizontal' or 'vertical'. The orientation
 *  should match the layout of the items. Items displayed in a single row
 *  or in several rows should use horizontal orientation. The vertical orientation should only be
 *  used when the items are displayed in a single column. Defaults to 'vertical'
 */
OO.ui.DraggableGroupElement = function OoUiDraggableGroupElement( config ) {
	// Configuration initialization
	config = config || {};

	// Parent constructor
	OO.ui.GroupElement.call( this, config );

	// Properties
	this.orientation = config.orientation || 'vertical';
	this.dragItem = null;
	this.itemDragOver = null;
	this.itemKeys = {};
	this.sideInsertion = '';

	// Events
	this.aggregate( {
		dragstart: 'itemDragStart',
		dragend: 'itemDragEnd',
		drop: 'itemDrop'
	} );
	this.connect( this, {
		itemDragStart: 'onItemDragStart',
		itemDrop: 'onItemDrop',
		itemDragEnd: 'onItemDragEnd'
	} );
	this.$element.on( {
		dragover: $.proxy( this.onDragOver, this ),
		dragleave: $.proxy( this.onDragLeave, this )
	} );

	// Initialize
	if ( Array.isArray( config.items ) ) {
		this.addItems( config.items );
	}
	this.$placeholder = $( '<div>' )
		.addClass( 'oo-ui-draggableGroupElement-placeholder' );
	this.$element
		.addClass( 'oo-ui-draggableGroupElement' )
		.append( this.$status )
		.toggleClass( 'oo-ui-draggableGroupElement-horizontal', this.orientation === 'horizontal' )
		.prepend( this.$placeholder );
};

/* Setup */
OO.mixinClass( OO.ui.DraggableGroupElement, OO.ui.GroupElement );

/* Events */

/**
 * A 'reorder' event is emitted when the order of items in the group changes.
 *
 * @event reorder
 * @param {OO.ui.DraggableElement} item Reordered item
 * @param {number} [newIndex] New index for the item
 */

/* Methods */

/**
 * Respond to item drag start event
 *
 * @private
 * @param {OO.ui.DraggableElement} item Dragged item
 */
OO.ui.DraggableGroupElement.prototype.onItemDragStart = function ( item ) {
	var i, len;

	// Map the index of each object
	for ( i = 0, len = this.items.length; i < len; i++ ) {
		this.items[ i ].setIndex( i );
	}

	if ( this.orientation === 'horizontal' ) {
		// Set the height of the indicator
		this.$placeholder.css( {
			height: item.$element.outerHeight(),
			width: 2
		} );
	} else {
		// Set the width of the indicator
		this.$placeholder.css( {
			height: 2,
			width: item.$element.outerWidth()
		} );
	}
	this.setDragItem( item );
};

/**
 * Respond to item drag end event
 *
 * @private
 */
OO.ui.DraggableGroupElement.prototype.onItemDragEnd = function () {
	this.unsetDragItem();
	return false;
};

/**
 * Handle drop event and switch the order of the items accordingly
 *
 * @private
 * @param {OO.ui.DraggableElement} item Dropped item
 * @fires reorder
 */
OO.ui.DraggableGroupElement.prototype.onItemDrop = function ( item ) {
	var toIndex = item.getIndex();
	// Check if the dropped item is from the current group
	// TODO: Figure out a way to configure a list of legally droppable
	// elements even if they are not yet in the list
	if ( this.getDragItem() ) {
		// If the insertion point is 'after', the insertion index
		// is shifted to the right (or to the left in RTL, hence 'after')
		if ( this.sideInsertion === 'after' ) {
			toIndex++;
		}
		// Emit change event
		this.emit( 'reorder', this.getDragItem(), toIndex );
	}
	this.unsetDragItem();
	// Return false to prevent propogation
	return false;
};

/**
 * Handle dragleave event.
 *
 * @private
 */
OO.ui.DraggableGroupElement.prototype.onDragLeave = function () {
	// This means the item was dragged outside the widget
	this.$placeholder
		.css( 'left', 0 )
		.addClass( 'oo-ui-element-hidden' );
};

/**
 * Respond to dragover event
 *
 * @private
 * @param {jQuery.Event} event Event details
 */
OO.ui.DraggableGroupElement.prototype.onDragOver = function ( e ) {
	var dragOverObj, $optionWidget, itemOffset, itemMidpoint, itemBoundingRect,
		itemSize, cssOutput, dragPosition, itemIndex, itemPosition,
		clientX = e.originalEvent.clientX,
		clientY = e.originalEvent.clientY;

	// Get the OptionWidget item we are dragging over
	dragOverObj = this.getElementDocument().elementFromPoint( clientX, clientY );
	$optionWidget = $( dragOverObj ).closest( '.oo-ui-draggableElement' );
	if ( $optionWidget[ 0 ] ) {
		itemOffset = $optionWidget.offset();
		itemBoundingRect = $optionWidget[ 0 ].getBoundingClientRect();
		itemPosition = $optionWidget.position();
		itemIndex = $optionWidget.data( 'index' );
	}

	if (
		itemOffset &&
		this.isDragging() &&
		itemIndex !== this.getDragItem().getIndex()
	) {
		if ( this.orientation === 'horizontal' ) {
			// Calculate where the mouse is relative to the item width
			itemSize = itemBoundingRect.width;
			itemMidpoint = itemBoundingRect.left + itemSize / 2;
			dragPosition = clientX;
			// Which side of the item we hover over will dictate
			// where the placeholder will appear, on the left or
			// on the right
			cssOutput = {
				left: dragPosition < itemMidpoint ? itemPosition.left : itemPosition.left + itemSize,
				top: itemPosition.top
			};
		} else {
			// Calculate where the mouse is relative to the item height
			itemSize = itemBoundingRect.height;
			itemMidpoint = itemBoundingRect.top + itemSize / 2;
			dragPosition = clientY;
			// Which side of the item we hover over will dictate
			// where the placeholder will appear, on the top or
			// on the bottom
			cssOutput = {
				top: dragPosition < itemMidpoint ? itemPosition.top : itemPosition.top + itemSize,
				left: itemPosition.left
			};
		}
		// Store whether we are before or after an item to rearrange
		// For horizontal layout, we need to account for RTL, as this is flipped
		if (  this.orientation === 'horizontal' && this.$element.css( 'direction' ) === 'rtl' ) {
			this.sideInsertion = dragPosition < itemMidpoint ? 'after' : 'before';
		} else {
			this.sideInsertion = dragPosition < itemMidpoint ? 'before' : 'after';
		}
		// Add drop indicator between objects
		this.$placeholder
			.css( cssOutput )
			.removeClass( 'oo-ui-element-hidden' );
	} else {
		// This means the item was dragged outside the widget
		this.$placeholder
			.css( 'left', 0 )
			.addClass( 'oo-ui-element-hidden' );
	}
	// Prevent default
	e.preventDefault();
};

/**
 * Set a dragged item
 *
 * @param {OO.ui.DraggableElement} item Dragged item
 */
OO.ui.DraggableGroupElement.prototype.setDragItem = function ( item ) {
	this.dragItem = item;
};

/**
 * Unset the current dragged item
 */
OO.ui.DraggableGroupElement.prototype.unsetDragItem = function () {
	this.dragItem = null;
	this.itemDragOver = null;
	this.$placeholder.addClass( 'oo-ui-element-hidden' );
	this.sideInsertion = '';
};

/**
 * Get the item that is currently being dragged.
 *
 * @return {OO.ui.DraggableElement|null} The currently dragged item, or `null` if no item is being dragged
 */
OO.ui.DraggableGroupElement.prototype.getDragItem = function () {
	return this.dragItem;
};

/**
 * Check if an item in the group is currently being dragged.
 *
 * @return {Boolean} Item is being dragged
 */
OO.ui.DraggableGroupElement.prototype.isDragging = function () {
	return this.getDragItem() !== null;
};
