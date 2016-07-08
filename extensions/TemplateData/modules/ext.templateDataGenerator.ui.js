( function () {
	'use strict';
	/**
	 * TemplateData Generator data model.
	 * This singleton is independent of any UI; it expects
	 * a templatedata string, converts it into the object
	 * model and manages it, fully event-driven.
	 *
	 * @class
	 * @singleton
	 */
	mw.libs.tdgUi = ( function () {
		var isPageSubLevel,
			isDocPage,
			pageName,
			parentPage,
			$textbox,
			// ooui Window Manager
			sourceHandler,
			tdgDialog,
			messageDialog,
			windowManager,
			// Edit window elements
			editOpenDialogButton,
			editNoticeLabel,

		editArea = {
			/**
			 * Display error message in the edit window
			 *
			 * @param {string} msg Message to display
			 * @param {string} [type='error'] Message type 'notice' or 'warning' or 'error'
			 * @param {boolean} [parseHTML] The message should be parsed
			 */
			setNoticeMessage: function ( msg, type, parseHTML ) {
				type = type || 'error';
				editNoticeLabel.$element
					.toggleClass( 'errorbox', type === 'error' )
					.toggleClass( 'warningbox', type === 'warning' );

				if ( parseHTML ) {
					// OOUI's label elements do not parse strings and display them
					// as-is. If the message contains html that should be parsed,
					// we have to transform it into a jQuery object
					msg = $( '<span>' ).append( $.parseHTML( msg ) );
				}
				editNoticeLabel.setLabel( msg );
				editNoticeLabel.toggle( true );
			},

			/**
			 * Reset the error message in the edit window
			 */
			resetNoticeMessage: function () {
				editNoticeLabel.setLabel( '' );
				editNoticeLabel.toggle( false );
			}
		},

		/**
		 * Open the templatedata edit dialog
		 *
		 * @method openEditDialog
		 * @param {mw.TemplateData.Model} dataModel The data model
		 * associated with this edit dialog.
		 */
		openEditDialog = function ( dataModel ) {
			// Open the edit dialog
			windowManager.openWindow( tdgDialog, {
				model: dataModel
			} );
		},

		/**
		 * Respond to edit dialog button click.
		 *
		 * @method onEditOpenDialogButton
		 */
		onEditOpenDialogButton = function () {
			// Reset notice message
			editArea.resetNoticeMessage();

			// Build the model
			sourceHandler.buildModel( $textbox.val() )
				.then(
					// Success
					function ( model ) {
						openEditDialog( model );
					},
					// Failure
					function () {
						// Open a message dialog
						windowManager.openWindow( messageDialog, {
							title: mw.msg( 'templatedata-modal-title' ),
							message: mw.msg( 'templatedata-errormsg-jsonbadformat' ),
							actions: [
								{
									action: 'accept',
									label: mw.msg( 'templatedata-modal-json-error-replace' ),
									flags: [ 'primary', 'destructive' ]
								},
								{
									action: 'reject',
									label: OO.ui.deferMsg( 'ooui-dialog-message-reject' ),
									flags: 'safe'
								}
							]
						} )
							.then( function ( opening ) {
								return opening;
							} )
							.then( function ( opened ) {
								return opened;
							} )
							.then( function ( data ) {
								var model;
								if ( data && data.action === 'accept' ) {
									// Open the dialog with an empty model
									model = new mw.TemplateData.Model.static.newFromObject(
										{ params: {} },
										sourceHandler.getTemplateSourceCodeParams()
									);
									openEditDialog( model );
								}
							} );
					}
				);
		},

		/**
		 * Replace the old templatedata string with the new one, or
		 * insert the new one into the page if an old one doesn't exist
		 *
		 * @method replaceTemplateData
		 * @param {Object} newTemplateData New templatedata
		 * @return {string} Full wikitext content with the new templatedata
		 *  string.
		 */
		replaceTemplateData = function ( newTemplateData ) {
			var finalOutput,
				fullWikitext = $textbox.val(),
				endNoIncludeLength = '</noinclude>'.length,
				// NB: This pattern contains no matching groups: (). This avoids
				// corruption if the template data JSON contains $1 etc.
				templatedataPattern = /<templatedata>[\s\S]*?<\/templatedata>/i;

			if ( fullWikitext.match( templatedataPattern ) ) {
				// <templatedata> exists. Replace it
				finalOutput = fullWikitext.replace(
					templatedataPattern,
					'<templatedata>\n' + JSON.stringify( newTemplateData, null, '\t' ) + '\n</templatedata>'
				);
			} else {
				finalOutput = fullWikitext;
				if ( finalOutput.substr( -1 ) !== '\n' ) {
					finalOutput += '\n';
				}

				if ( !isPageSubLevel ) {
					if ( finalOutput.substr( -endNoIncludeLength - 1 ) === '</noinclude>\n' ) {
						finalOutput = finalOutput.substr( 0, finalOutput.length - endNoIncludeLength - 1 );
					} else {
						finalOutput += '<noinclude>\n';
					}
				}
				finalOutput += '<templatedata>\n' +
						JSON.stringify( newTemplateData, null, '\t' ) +
						'\n</templatedata>\n';
				if ( !isPageSubLevel ) {
					finalOutput += '</noinclude>\n';
				}
			}
			return finalOutput;
		},

		/**
		 * Respond to edit dialog apply event
		 *
		 * @method onDialogApply
		 * @param {Object} templateData New templatedata
		 */
		onDialogApply = function ( templateData ) {
			$textbox.val( replaceTemplateData( templateData ) );
		};

		return {
			/**
			 * Initialize UI
			 *
			 * @param {jQuery} $container The container to attach UI buttons to
			 * @param {jQuery} $editorTextbox The editor textbox to take the
			 *  current wikitext from.
			 */
			init: function ( $container, $editorTextbox, userConfig ) {
				var editHelpButtonWidget, relatedPage,
					config = userConfig;

				$textbox = $editorTextbox;

				pageName = config.pageName;
				parentPage = config.parentPage;
				isPageSubLevel = !!config.isPageSubLevel;
				isDocPage = !!config.isDocPage;

				editOpenDialogButton = new OO.ui.ButtonWidget( {
					label: mw.msg( 'templatedata-editbutton' )
				} );

				editNoticeLabel = new OO.ui.LabelWidget( {
					classes: [ 'tdg-editscreen-error-msg' ]
				} )
					.toggle( false );

				editHelpButtonWidget = new OO.ui.ButtonWidget( {
					label: mw.msg( 'templatedata-helplink' ),
					classes: [ 'tdg-editscreen-main-helplink' ],
					href: mw.msg( 'templatedata-helplink-target' ),
					target: '_blank',
					framed: false
				} );

				// Dialog
				windowManager = new OO.ui.WindowManager();
				tdgDialog = new mw.TemplateData.Dialog( config );
				messageDialog = new OO.ui.MessageDialog();
				windowManager.addWindows( [ tdgDialog, messageDialog ] );

				sourceHandler = new mw.TemplateData.SourceHandler( {
					fullPageName: pageName,
					parentPage: parentPage,
					isPageSubLevel: isPageSubLevel
				} );

				// Check if there's already a templatedata in a related page
				// TODO: Hard-coding 'doc' is dangerous for i18n. We need to find
				// a better way to define 'related' pages for a template.
				relatedPage = isDocPage ? parentPage : pageName + '/doc';
				sourceHandler.getApi( relatedPage )
					.then( function ( result ) {
						var msg, matches, content,
							response = result.query.pages[ result.query.pageids[ 0 ] ];
						// HACK: When checking whether a related page (parent for /doc page or
						// vice versa) already has a templatedata string, we shouldn't
						// ask for the 'templatedata' action but rather the actual content
						// of the related page, otherwise we get embedded templatedata and
						// wrong information is presented.
						if ( response.missing === undefined ) {
							content = response.revisions[ 0 ][ '*' ];
							matches = content.match( /<templatedata>/i );
							// There's a templatedata string
							if ( matches ) {
								// HACK: Setting a link in the messages doesn't work. The bug report offers
								// a somewhat hacky work around that includes setting a separate message
								// to be parsed.
								// https://phabricator.wikimedia.org/T49395#490610
								msg = mw.message( 'templatedata-exists-on-related-page', relatedPage ).plain();
								mw.messages.set( { 'templatedata-string-exists-hack-message': msg } );
								msg = mw.message( 'templatedata-string-exists-hack-message' ).parse();

								editArea.setNoticeMessage( msg, 'warning', true );
							}
						}
					} );

				// Prepend to container
				$container
					.prepend(
						$( '<div>' )
							.addClass( 'tdg-editscreen-main' )
							.append(
								editOpenDialogButton.$element,
								editHelpButtonWidget.$element,
								editNoticeLabel.$element
							)
					);
				$( 'body' )
					.append( windowManager.$element );

				// UI events
				editOpenDialogButton.connect( this, { click: onEditOpenDialogButton } );

				tdgDialog.connect( this, {
					apply: onDialogApply
				} );
			}
		};
	}() );
}() );
