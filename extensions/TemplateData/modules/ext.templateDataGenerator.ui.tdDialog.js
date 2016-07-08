/**
 * TemplateData Dialog
 *
 * @class
 * @extends OO.ui.ProcessDialog
 *
 * @constructor
 * @param {Object} config Dialog configuration object
 */
mw.TemplateData.Dialog = function mwTemplateDataDialog( config ) {
	// Parent constructor
	mw.TemplateData.Dialog.parent.call( this, config );

	this.model = null;
	this.modified = false;
	this.language = null;
	this.availableLanguages = [];
	this.selectedParamKey = '';
	this.propInputs = {};
	this.propFieldLayout = {};
	this.isSetup = false;

	// Initialize
	this.$element.addClass( 'tdg-templateDataDialog' );
};

/* Inheritance */

OO.inheritClass( mw.TemplateData.Dialog, OO.ui.ProcessDialog );

/* Static properties */
mw.TemplateData.Dialog.static.name = 'TemplateDataDialog';
mw.TemplateData.Dialog.static.title = mw.msg( 'templatedata-modal-title' );
mw.TemplateData.Dialog.static.size = 'large';
mw.TemplateData.Dialog.static.actions = [
	{
		action: 'apply',
		label: mw.msg( 'templatedata-modal-button-apply' ),
		flags: [ 'primary', 'constructive' ],
		modes: 'list'
	},
	{
		action: 'done',
		label: mw.msg( 'templatedata-modal-button-done' ),
		flags: [ 'primary', 'progressive' ],
		modes: 'edit'
	},
	{
		action: 'add',
		label: mw.msg( 'templatedata-modal-button-addparam' ),
		flags: [ 'constructive' ],
		modes: 'list'
	},
	{
		action: 'delete',
		label: mw.msg( 'templatedata-modal-button-delparam' ),
		modes: 'edit',
		flags: 'destructive'
	},
	{
		label: mw.msg( 'templatedata-modal-button-cancel' ),
		flags: 'safe',
		modes: [ 'list', 'error' ]
	},
	{
		action: 'back',
		label: mw.msg( 'templatedata-modal-button-back' ),
		flags: 'safe',
		modes: [ 'language', 'add' ]
	}
];

/**
 * Initialize window contents.
 *
 * The first time the window is opened, #initialize is called so that changes to the window that
 * will persist between openings can be made. See #getSetupProcess for a way to make changes each
 * time the window opens.
 *
 * @throws {Error} If not attached to a manager
 * @chainable
 */
mw.TemplateData.Dialog.prototype.initialize = function () {
	var templateParamsFieldset, addParamFieldlayout, languageActionFieldLayout, templateFormatFieldSet;

	// Parent method
	mw.TemplateData.Dialog.super.prototype.initialize.call( this );

	this.$spinner = this.$( '<div>' ).addClass( 'tdg-spinner' ).text( 'working...' );
	this.$body.append( this.$spinner );

	this.noticeLabel = new OO.ui.LabelWidget();
	this.noticeLabel.$element.hide();

	this.panels = new OO.ui.StackLayout( { continuous: false } );

	this.listParamsPanel = new OO.ui.PanelLayout( { scrollable: true } );
	this.editParamPanel = new OO.ui.PanelLayout();
	this.languagePanel = new OO.ui.PanelLayout();
	this.addParamPanel = new OO.ui.PanelLayout();

	// Language panel
	this.newLanguageSearch = new mw.TemplateData.LanguageSearchWidget();

	// Add parameter panel
	this.newParamInput = new OO.ui.TextInputWidget( {
		placeholder: mw.msg( 'templatedata-modal-placeholder-paramkey' )
	} );
	this.addParamButton = new OO.ui.ButtonWidget( {
		label: mw.msg( 'templatedata-modal-button-addparam' )
	} );
	addParamFieldlayout = new OO.ui.ActionFieldLayout(
		this.newParamInput,
		this.addParamButton,
		{
			align: 'top',
			label: mw.msg( 'templatedata-modal-title-addparam' )
		}
	);

	// Param list panel (main)
	this.languageDropdownWidget = new OO.ui.DropdownWidget();
	this.languagePanelButton = new OO.ui.ButtonWidget( {
		label: mw.msg( 'templatedata-modal-button-add-language' )
	} );

	languageActionFieldLayout = new OO.ui.ActionFieldLayout(
		this.languageDropdownWidget,
		this.languagePanelButton,
		{
			align: 'left',
			label: mw.msg( 'templatedata-modal-title-language' )
		}
	);

	this.descriptionInput = new OO.ui.TextInputWidget( {
		multiline: true,
		autosize: true
	} );
	this.templateDescriptionFieldset = new OO.ui.FieldsetLayout( {
		items: [ this.descriptionInput ]
	} );
	this.paramListNoticeLabel = new OO.ui.LabelWidget();
	this.paramListNoticeLabel.$element.hide();

	this.paramSelect = new mw.TemplateData.ParamSelectWidget();
	templateParamsFieldset = new OO.ui.FieldsetLayout( {
		label: mw.msg( 'templatedata-modal-title-templateparams' )
	} );
	this.paramImport = new mw.TemplateData.ParamImportWidget();
	templateParamsFieldset.$element.append( this.paramSelect.$element, this.paramImport.$element );

	this.templateFormatSelectWidget = new OO.ui.ButtonSelectWidget();
	this.templateFormatSelectWidget.addItems( [
		new OO.ui.ButtonOptionWidget( {
			data: 'inline',
			icon: 'template-format-inline',
			label: mw.msg( 'templatedata-modal-format-inline' )
		} ),
		new OO.ui.ButtonOptionWidget( {
			data: 'block',
			icon: 'template-format-block',
			label: mw.msg( 'templatedata-modal-format-block' )
		} ),
		new OO.ui.ButtonOptionWidget( {
			data: null,
			label: mw.msg( 'templatedata-modal-format-null' )
		} )
	] );

	templateFormatFieldSet = new OO.ui.FieldsetLayout( {
		label: mw.msg( 'templatedata-modal-title-templateformat' )
	} );
	templateFormatFieldSet.$element.append( this.templateFormatSelectWidget.$element );

	// Param details panel
	this.$paramDetailsContainer = $( '<div>' )
		.addClass( 'tdg-templateDataDialog-paramDetails' );

	this.listParamsPanel.$element
		.addClass( 'tdg-templateDataDialog-listParamsPanel' )
		.append(
			this.paramListNoticeLabel.$element,
			languageActionFieldLayout.$element,
			this.templateDescriptionFieldset.$element,
			templateFormatFieldSet.$element,
			templateParamsFieldset.$element
		);
	this.paramEditNoticeLabel = new OO.ui.LabelWidget();
	this.paramEditNoticeLabel.$element.hide();
	// Edit panel
	this.editParamPanel.$element
		.addClass( 'tdg-templateDataDialog-editParamPanel' )
		.append(
			this.paramEditNoticeLabel.$element,
			this.$paramDetailsContainer
		);
	// Language panel
	this.languagePanel.$element
		.addClass( 'tdg-templateDataDialog-languagePanel' )
		.append(
			this.newLanguageSearch.$element
		);
	this.addParamPanel.$element
		.addClass( 'tdg-templateDataDialog-addParamPanel' )
		.append( addParamFieldlayout.$element );

	this.panels.addItems( [
		this.listParamsPanel,
		this.editParamPanel,
		this.languagePanel,
		this.addParamPanel
	] );
	this.panels.setItem( this.listParamsPanel );
	this.panels.$element.addClass( 'tdg-templateDataDialog-panels' );

	// Build param details panel
	this.$paramDetailsContainer.append( this.createParamDetails() );

	// Initialization
	this.$body.append(
		this.noticeLabel.$element,
		this.panels.$element
	);

	// Events
	this.newLanguageSearch.getResults().connect( this, { choose: 'onNewLanguageSearchResultsChoose' } );
	this.newParamInput.connect( this, { change: 'onAddParamInputChange' } );
	this.addParamButton.connect( this, { click: 'onAddParamButtonClick' } );
	this.descriptionInput.connect( this, { change: 'onDescriptionInputChange' } );
	this.languagePanelButton.connect( this, { click: 'onLanguagePanelButton' } );
	this.languageDropdownWidget.getMenu().connect( this, { select: 'onLanguageDropdownWidgetSelect' } );
	this.paramSelect.connect( this, {
		choose: 'onParamSelectChoose',
		reorder: 'onParamSelectReorder'
	} );
	this.paramImport.connect( this, { click: 'importParametersFromTemplateCode' } );
	this.templateFormatSelectWidget.connect( this, { choose: 'onTemplateFormatSelectWidgetChoose' } );

};

/**
 * Respond to model change of description event
 *
 * @param {string} description New description
 */
mw.TemplateData.Dialog.prototype.onModelChangeDescription = function ( description ) {
	this.descriptionInput.setValue( description );
};

/**
 * Respond to add param input change.
 *
 * @param {string} value New parameter name
 */
mw.TemplateData.Dialog.prototype.onAddParamInputChange = function ( value ) {
	var allProps = mw.TemplateData.Model.static.getAllProperties( true );

	if (
		value.match( allProps.name.restrict ) ||
		(
			this.model.isParamExists( value ) &&
			!this.model.isParamDeleted( value )
		)
	) {
		// Disable the add button
		this.addParamButton.setDisabled( true );
	} else {
		this.addParamButton.setDisabled( false );
	}
};

/**
 * Respond to change of param order from the model
 *
 * @param {...string[]} paramOrderArray The array of keys in order
 */
mw.TemplateData.Dialog.prototype.onModelChangeParamOrder = function () {
	// Refresh the parameter widget
	this.repopulateParamSelectWidget();
};

/**
 * Respond to a change in the model
 */
mw.TemplateData.Dialog.prototype.onModelChange = function () {
	this.modified = true;
};

/**
 * Respond to param order widget reorder event
 *
 * @param {mw.TemplateData.ParamWidget} item Item reordered
 * @param {number} newIndex New index of the item
 */
mw.TemplateData.Dialog.prototype.onParamSelectReorder = function ( item, newIndex ) {
	this.model.reorderParamOrderKey( item.getData(), newIndex );
};

/**
 * Respond to description input change event
 *
 * @param {string} value Description value
 */
mw.TemplateData.Dialog.prototype.onDescriptionInputChange = function ( value ) {
	if ( this.model.getTemplateDescription() !== value ) {
		this.model.setTemplateDescription( value, this.language );
	}
};

/**
 * Respond to add language button click
 */
mw.TemplateData.Dialog.prototype.onLanguagePanelButton = function () {
	this.switchPanels( 'language' );
};

/**
 * Respond to language select widget select event
 *
 * @param {OO.ui.OptionWidget} item Selected item
 */
mw.TemplateData.Dialog.prototype.onLanguageDropdownWidgetSelect = function ( item ) {
	var language = item ? item.getData() : this.language;

	// Change current language
	if ( language !== this.language ) {
		this.language = language;

		// Update description label
		this.templateDescriptionFieldset.setLabel( mw.msg( 'templatedata-modal-title-templatedesc', this.language ) );

		// Update description value
		this.descriptionInput.setValue( this.model.getTemplateDescription( language ) );

		// Update all param descriptions in the param select widget
		this.repopulateParamSelectWidget();

		// Update the parameter detail page
		this.updateParamDetailsLanguage( this.language );

		this.emit( 'change-language', this.language );
	}
};

/**
 * Handle choose events from the new language search widget
 *
 * @param {mw.TemplateData.LanguageResultWidget} item Chosen item
 */
mw.TemplateData.Dialog.prototype.onNewLanguageSearchResultsChoose = function ( item ) {
	var languageButton,
		newLanguage = item.getData().code;

	if ( newLanguage ) {
		if ( $.inArray( newLanguage, this.availableLanguages ) === -1 ) {
			// Add new language
			this.availableLanguages.push( newLanguage );
			languageButton = new OO.ui.MenuOptionWidget( {
				data: newLanguage,
				label: $.uls.data.getAutonym( newLanguage )
			} );
			this.languageDropdownWidget.getMenu().addItems( [ languageButton ] );
		}

		// Select the new item
		this.languageDropdownWidget.getMenu().selectItemByData( newLanguage );
	}

	// Go to the main panel
	this.switchPanels( 'listParams' );
};

/**
 * Respond to add parameter button
 */
mw.TemplateData.Dialog.prototype.onAddParamButtonClick = function () {
	var newParamKey = this.newParamInput.getValue(),
		allProps = mw.TemplateData.Model.static.getAllProperties( true );

	// Validate parameter
	if ( !newParamKey.match( allProps.name.restrict ) ) {
		if ( this.model.isParamDeleted( newParamKey ) ) {
			// Empty param
			this.model.emptyParamData( newParamKey );
		} else if ( !this.model.isParamExists( newParamKey ) ) {
			// Add to model
			if ( this.model.addParam( newParamKey ) ) {
				// Add parameter to list
				this.addParamToSelectWidget( newParamKey );
			}
		}
	}
	// Reset the input
	this.newParamInput.setValue( '' );

	// Go back to list
	this.switchPanels( 'listParams' );
};

/**
 * Respond to choose event from the param select widget
 *
 * @param {OO.ui.OptionWidget} item Parameter item
 */
mw.TemplateData.Dialog.prototype.onParamSelectChoose = function ( item ) {
	var paramKey = item.getData();

	this.selectedParamKey = paramKey;

	// Fill in parameter detail
	this.getParameterDetails( paramKey );
	this.switchPanels( 'editParam' );
};

/**
 * Respond to choose event from the template format select widget
 *
 * @param {OO.ui.OptionWidget} item Format item
 */
mw.TemplateData.Dialog.prototype.onTemplateFormatSelectWidgetChoose = function ( item ) {
	this.model.setTemplateFormat( item.getData() );
};

mw.TemplateData.Dialog.prototype.onParamPropertyInputChange = function ( property, value ) {
	var err = false,
		anyInputError = false,
		allProps = mw.TemplateData.Model.static.getAllProperties( true );

	if ( property === 'type' ) {
		value = this.propInputs[ property ].getMenu().getSelectedItem() ? this.propInputs[ property ].getMenu().getSelectedItem().getData() : 'unknown';
	}

	// TODO: Validate the name
	if ( allProps[ property ].restrict ) {
		if ( value.match( allProps[ property ].restrict ) ) {
			// Error! Don't fix the model
			err = true;
			this.toggleNoticeMessage( 'edit', true, 'error', mw.msg( 'templatedata-modal-errormsg', '|', '=', '}}' ) );
		} else {
			this.toggleNoticeMessage( 'edit', false );
		}
	}

	this.propInputs[ property ].$element.toggleClass( 'tdg-editscreen-input-error', err );

	// Check if there is a dependent input to activate
	if ( allProps[ property ].textValue && this.propFieldLayout[ allProps[ property ].textValue ] ) {
		// The textValue property depends on this property
		// toggle its view
		this.propFieldLayout[ allProps[ property ].textValue ].toggle( !!value );
		this.propInputs[ allProps[ property ].textValue ].setValue( this.model.getParamProperty( this.selectedParamKey, allProps[ property ].textValue ) );
	}

	// Validate
	$( '.tdg-templateDataDialog-paramInput' ).each( function () {
		if ( $( this ).hasClass( 'tdg-editscreen-input-error' ) ) {
			anyInputError = true;
		}
	} );

	// Disable the 'back' button if there are any errors in the inputs
	this.actions.setAbilities( { back: !anyInputError } );
	if ( !err ) {
		this.model.setParamProperty( this.selectedParamKey, property, value, this.language );
	}
};

/**
 * Set the parameter details in the detail panel.
 *
 * @param {Object} paramKey Parameter details
 */
mw.TemplateData.Dialog.prototype.getParameterDetails = function ( paramKey ) {
	var prop,
		paramData = this.model.getParamData( paramKey ),
		allProps = mw.TemplateData.Model.static.getAllProperties( true );

	for ( prop in this.propInputs ) {
		this.changeParamPropertyInput( paramKey, prop, paramData[ prop ], this.language );
		// Show/hide dependents
		if ( allProps[ prop ].textValue ) {
			this.propFieldLayout[ allProps[ prop ].textValue ].toggle( !!paramData[ prop ] );
		}
	}

};

/**
 * Reset contents on reload
 */
mw.TemplateData.Dialog.prototype.reset = function () {
	this.language = null;
	this.availableLanguages = [];
	if ( this.paramSelect ) {
		this.paramSelect.clearItems();
		this.selectedParamKey = '';
	}

	if ( this.languageDropdownWidget ) {
		this.languageDropdownWidget.getMenu().clearItems();
	}
};

/**
 * Empty and repopulate the parameter select widget.
 */
mw.TemplateData.Dialog.prototype.repopulateParamSelectWidget = function () {
	var i, paramKey, missingParams, paramList, paramOrder;

	if ( !this.isSetup ) {
		return;
	}

	missingParams = this.model.getMissingParams();
	paramList = this.model.getParams();
	paramOrder = this.model.getTemplateParamOrder();

	this.paramSelect.clearItems();

	// Update all param descriptions in the param select widget
	for ( i in paramOrder ) {
		paramKey = paramList[ paramOrder[ i ] ];
		if ( paramKey && !paramKey.deleted ) {
			this.addParamToSelectWidget( paramOrder[ i ] );
		}
	}

	// Check if there are potential parameters to add
	// from the template source code
	if ( missingParams.length > 0 ) {
		this.paramImport
			.toggle( true )
			.buildParamLabel( missingParams );
	} else {
		this.paramImport.toggle( false );
	}
};

/**
 * Change parameter property
 *
 * @param {string} paramKey Parameter key
 * @param {string} propName Property name
 * @param {string} value Property value
 * @param {string} [lang] Language
 */
mw.TemplateData.Dialog.prototype.changeParamPropertyInput = function ( paramKey, propName, value, lang ) {
	var languageProps = mw.TemplateData.Model.static.getPropertiesWithLanguage(),
		allProps = mw.TemplateData.Model.static.getAllProperties( true ),
		prop = allProps[ propName ],
		propInput = typeof this.propInputs[ propName ].getMenu === 'function' ?
			this.propInputs[ propName ].getMenu() : this.propInputs[ propName ];

	lang = lang || this.language;

	if ( value !== undefined ) {
		// Change the actual input
		if ( prop.type === 'select' ) {
			propInput.selectItem( propInput.getItemFromData( value ) );
		} else if ( prop.type === 'boolean' ) {
			propInput.setSelected( !!value );
		} else {
			if ( $.inArray( propName, languageProps ) !== -1 ) {
				propInput.setValue( value[ lang ] );
			} else {
				if ( prop.type === 'array' && $.type( value ) === 'array' ) {
					value = value.join( prop.delimiter );
				}
				propInput.setValue( value );
			}
		}
	} else {
		// Empty the input
		if ( prop.type === 'select' ) {
			propInput.selectItem( propInput.getItemFromData( prop[ 'default' ] ) );
		} else if ( prop.type === 'boolean' ) {
			propInput.setSelected( false );
		} else {
			propInput.setValue( '' );
		}
	}
};

/**
 * Add parameter to the list
 *
 * @param {string} paramKey Parameter key in the model
 */
mw.TemplateData.Dialog.prototype.addParamToSelectWidget = function ( paramKey ) {
	var paramItem,
		data = this.model.getParamData( paramKey );

	paramItem = new mw.TemplateData.ParamWidget( {
		key: paramKey,
		label: this.model.getParamValue( paramKey, 'label', this.language ),
		aliases: data.aliases,
		description: this.model.getParamValue( paramKey, 'description', this.language )
	} );

	this.paramSelect.addItems( [ paramItem ] );
};

/**
 * Create the information page about individual parameters
 *
 * @return {jQuery} Editable details page for the parameter
 */
mw.TemplateData.Dialog.prototype.createParamDetails = function () {
	var props, type, propInput, config, paramProperties,
		paramFieldset,
		typeItemArray = [];

	paramProperties = mw.TemplateData.Model.static.getAllProperties( true );

	// Fieldset
	paramFieldset = new OO.ui.FieldsetLayout();

	for ( props in paramProperties ) {
		config = {
			multiline: paramProperties[ props ].multiline
		};
		if ( paramProperties[ props ].multiline ) {
			config.autosize = true;
		}
		// Create the property inputs
		switch ( props ) {
			case 'type':
				propInput = new OO.ui.DropdownWidget( config );
				for ( type in paramProperties[ props ].children ) {
					typeItemArray.push( new OO.ui.MenuOptionWidget( {
						data: paramProperties[ props ].children[ type ],

						// Known messages, for grepping:
						// templatedata-doc-param-type-boolean, templatedata-doc-param-type-content,
						// templatedata-doc-param-type-date, templatedata-doc-param-type-line,
						// templatedata-doc-param-type-number, templatedata-doc-param-type-string,
						// templatedata-doc-param-type-unbalanced-wikitext, templatedata-doc-param-type-unknown,
						// templatedata-doc-param-type-url, templatedata-doc-param-type-wiki-file-name,
						// templatedata-doc-param-type-wiki-page-name, templatedata-doc-param-type-wiki-template-name,
						// templatedata-doc-param-type-wiki-user-name
						label: mw.msg( 'templatedata-doc-param-type-' + paramProperties[ props ].children[ type ] )
					} ) );
				}
				propInput.getMenu().addItems( typeItemArray );
				break;
			case 'deprecated':
			case 'required':
			case 'suggested':
				propInput = new OO.ui.CheckboxInputWidget( config );
				break;
			default:
				propInput = new OO.ui.TextInputWidget( config );
				break;
		}

		this.propInputs[ props ] = propInput;

		propInput.$element
			.addClass( 'tdg-templateDataDialog-paramInput tdg-templateDataDialog-paramList-' + props );

		this.propFieldLayout[ props ] = new OO.ui.FieldLayout( propInput, {
			align: 'left',
			label: mw.msg( 'templatedata-modal-table-param-' + props )
		} );

		// Event
		if ( props === 'type' ) {
			propInput.getMenu().connect( this, { choose: [ 'onParamPropertyInputChange', props ] } );
		} else {
			propInput.connect( this, { change: [ 'onParamPropertyInputChange', props ] } );
		}
		// Append to parameter section
		paramFieldset.$element.append( this.propFieldLayout[ props ].$element );
	}
	// Update parameter property fields with languages
	this.updateParamDetailsLanguage( this.language );
	return paramFieldset.$element;
};

/**
 * Update the labels for parameter property inputs that include language, so
 * they show the currently used language.
 *
 * @param {string} [lang] Language. If not used, will use currently defined
 *  language.
 */
mw.TemplateData.Dialog.prototype.updateParamDetailsLanguage = function ( lang ) {
	var i, prop, label,
		languageProps = mw.TemplateData.Model.static.getPropertiesWithLanguage();
	lang = lang || this.language;

	for ( i = 0; i < languageProps.length; i++ ) {
		prop = languageProps[ i ];
		label = mw.msg( 'templatedata-modal-table-param-' + prop, lang );
		this.propFieldLayout[ prop ].setLabel( label );
	}
};

/**
 * Override getBodyHeight to create a tall dialog relative to the screen.
 *
 * @return {number} Body height
 */
mw.TemplateData.Dialog.prototype.getBodyHeight = function () {
	return window.innerHeight - 200;
};

/**
 * Show or hide the notice message in the dialog with a set message.
 *
 * @param {string} type Which notice label to show: 'list' or 'global'
 * @param {boolean} isShowing Show or hide the message
 * @param {string} status Message status 'error' or 'success'
 * @param {string|string[]} noticeMessage The message to display
 */
mw.TemplateData.Dialog.prototype.toggleNoticeMessage = function ( type, isShowing, status, noticeMessage ) {
	var noticeReference,
		$message;

	type = type || 'list';

	// Hide all
	this.noticeLabel.$element.hide();
	this.paramEditNoticeLabel.$element.hide();
	this.paramListNoticeLabel.$element.hide();

	if ( noticeMessage ) {
		// See which error to display
		if ( type === 'global' ) {
			noticeReference = this.noticeLabel;
		} else if ( type === 'edit' ) {
			noticeReference = this.paramEditNoticeLabel;
		} else {
			noticeReference = this.paramListNoticeLabel;
		}
		isShowing = isShowing || !noticeReference.$element.is( ':visible' );

		if ( $.type( noticeMessage ) === 'array' ) {
			$message = $( '<div>' );
			$.each( noticeMessage, function ( i, msg ) {
				$message.append( $( '<p>' ).text( msg ) );
			} );
			noticeReference.setLabel( $message );
		} else {
			noticeReference.setLabel( noticeMessage );
		}
		noticeReference.$element
			.toggle( isShowing )
			.toggleClass( 'errorbox', status === 'error' )
			.toggleClass( 'successbox', status === 'success' );
	}
};

/**
 * Import parameters from the source code.
 */
mw.TemplateData.Dialog.prototype.importParametersFromTemplateCode = function () {
	var combinedMessage = [],
		state = 'success',
		response = this.model.importSourceCodeParameters();
	// Repopulate the list
	this.repopulateParamSelectWidget();

	if ( response.imported.length === 0 ) {
		combinedMessage.push( mw.msg( 'templatedata-modal-errormsg-import-noparams' ) );
		state = 'error';
	} else {
		combinedMessage.push( mw.msg( 'templatedata-modal-notice-import-numparams', response.imported.length, response.imported.join( mw.msg( 'comma-separator' ) ) ) );
	}

	this.toggleNoticeMessage( 'list', true, state, combinedMessage );
};

/**
 * Get a process for setting up a window for use.
 *
 * @param {Object} [data] Dialog opening data
 */
mw.TemplateData.Dialog.prototype.getSetupProcess = function ( data ) {
	return mw.TemplateData.Dialog.super.prototype.getSetupProcess.call( this, data )
		.next( function () {
			var i, language, languages,
				languageItems = [];

			this.isSetup = false;

			this.reset();

			// The dialog must be supplied with a reference to a model
			this.model = data.model;
			this.modified = false;

			// Hide the panels and display a spinner
			this.$spinner.show();
			this.panels.$element.hide();
			this.toggleNoticeMessage( 'global', false );
			this.toggleNoticeMessage( 'list', false );

			// Start with parameter list
			this.switchPanels( 'listParams' );

			// Events
			this.model.connect( this, {
				'change-description': 'onModelChangeDescription',
				'change-paramOrder': 'onModelChangeParamOrder',
				change: 'onModelChange'
			} );

			// Setup the dialog
			this.setupDetailsFromModel();

			this.newLanguageSearch.addResults();

			languageItems = [];
			language = this.model.getDefaultLanguage();
			languages = this.model.getExistingLanguageCodes();

			// Fill up the language selection
			if (
				languages.length === 0 ||
				$.inArray( language, languages ) === -1
			) {
				// Add the default language
				languageItems.push( new OO.ui.MenuOptionWidget( {
					data: language,
					label: $.uls.data.getAutonym( language )
				} ) );
				this.availableLanguages.push( language );
			}

			// Add all available languages
			for ( i = 0; i < languages.length; i++ ) {
				languageItems.push( new OO.ui.MenuOptionWidget( {
					data: languages[ i ],
					label: $.uls.data.getAutonym( languages[ i ] )
				} ) );
				// Store available languages
				this.availableLanguages.push( languages[ i ] );
			}
			this.languageDropdownWidget.getMenu().addItems( languageItems );
			// Trigger the initial language choice
			this.languageDropdownWidget.getMenu().selectItemByData( language );

			this.isSetup = true;

			this.repopulateParamSelectWidget();

			// Show the panel
			this.$spinner.hide();
			this.panels.$element.show();

		}, this );
};

/**
 * Set up the list of parameters from the model. This should happen
 * after initialization of the model.
 */
mw.TemplateData.Dialog.prototype.setupDetailsFromModel = function () {
	// Set up description
	this.descriptionInput.setValue( this.model.getTemplateDescription( this.language ) );

	// Set up format
	this.templateFormatSelectWidget.selectItemByData( this.model.getTemplateFormat() );

	// Repopulate the parameter list
	this.repopulateParamSelectWidget();
};

/**
 * Switch between stack layout panels
 *
 * @param {string} panel Panel key to switch to
 */
mw.TemplateData.Dialog.prototype.switchPanels = function ( panel ) {
	switch ( panel ) {
		case 'listParams':
			this.actions.setMode( 'list' );
			this.panels.setItem( this.listParamsPanel );
			// Reset message
			this.toggleNoticeMessage( 'list', false );
			// Deselect parameter
			this.paramSelect.selectItem( null );
			// Repopulate the list to account for any changes
			if ( this.model ) {
				this.repopulateParamSelectWidget();
			}
			// Hide/show panels
			this.listParamsPanel.$element.show();
			this.editParamPanel.$element.hide();
			this.addParamPanel.$element.hide();
			this.languagePanel.$element.hide();
			break;
		case 'editParam':
			this.actions.setMode( 'edit' );
			this.panels.setItem( this.editParamPanel );
			// Deselect parameter
			this.paramSelect.selectItem( null );
			// Hide/show panels
			this.listParamsPanel.$element.hide();
			this.languagePanel.$element.hide();
			this.addParamPanel.$element.hide();
			this.editParamPanel.$element.show();
			break;
		case 'addParam':
			this.actions.setMode( 'add' );
			this.panels.setItem( this.addParamPanel );
			// Hide/show panels
			this.listParamsPanel.$element.hide();
			this.editParamPanel.$element.hide();
			this.languagePanel.$element.hide();
			this.addParamPanel.$element.show();
			break;
		case 'language':
			this.actions.setMode( 'language' );
			this.panels.setItem( this.languagePanel );
			// Hide/show panels
			this.listParamsPanel.$element.hide();
			this.editParamPanel.$element.hide();
			this.addParamPanel.$element.hide();
			this.languagePanel.$element.show();
			this.newLanguageSearch.query.focus();
			break;
	}
};

/**
 * Get a process for taking action.
 *
 * @param {string} [action] Symbolic name of action
 * @return {OO.ui.Process} Action process
 */
mw.TemplateData.Dialog.prototype.getActionProcess = function ( action ) {
	if ( action === 'back' || action === 'done' ) {
		return new OO.ui.Process( function () {
			this.switchPanels( 'listParams' );
		}, this );
	}
	if ( action === 'add' ) {
		return new OO.ui.Process( function () {
			this.switchPanels( 'addParam' );
		}, this );
	}
	if ( action === 'delete' ) {
		return new OO.ui.Process( function () {
			this.model.deleteParam( this.selectedParamKey );
			this.switchPanels( 'listParams' );
		}, this );
	}
	if ( action === 'apply' ) {
		return new OO.ui.Process( function () {
			this.emit( 'apply', this.model.outputTemplateData() );
			this.close( { action: action } );
		}, this );
	}
	if ( !action && this.modified ) {
		return new OO.ui.Process( function () {
			var dialog = this;
			return OO.ui.confirm( mw.msg( 'templatedata-modal-confirmcancel' ) )
				.then( function ( result ) {
					if ( result ) {
						dialog.close();
					} else {
						return $.Deferred().resolve().promise();
					}
				} );
		}, this );
	}
	// Fallback to parent handler
	return mw.TemplateData.Dialog.super.prototype.getActionProcess.call( this, action );
};
