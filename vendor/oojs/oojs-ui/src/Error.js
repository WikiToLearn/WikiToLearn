/**
 * Errors contain a required message (either a string or jQuery selection) that is used to describe what went wrong
 * in a {@link OO.ui.Process process}. The error's #recoverable and #warning configurations are used to customize the
 * appearance and functionality of the error interface.
 *
 * The basic error interface contains a formatted error message as well as two buttons: 'Dismiss' and 'Try again' (i.e., the error
 * is 'recoverable' by default). If the error is not recoverable, the 'Try again' button will not be rendered and the widget
 * that initiated the failed process will be disabled.
 *
 * If the error is a warning, the error interface will include a 'Dismiss' and a 'Continue' button, which will try the
 * process again.
 *
 * For an example of error interfaces, please see the [OOjs UI documentation on MediaWiki][1].
 *
 * [1]: https://www.mediawiki.org/wiki/OOjs_UI/Windows/Process_Dialogs#Processes_and_errors
 *
 * @class
 *
 * @constructor
 * @param {string|jQuery} message Description of error
 * @param {Object} [config] Configuration options
 * @cfg {boolean} [recoverable=true] Error is recoverable.
 *  By default, errors are recoverable, and users can try the process again.
 * @cfg {boolean} [warning=false] Error is a warning.
 *  If the error is a warning, the error interface will include a
 *  'Dismiss' and a 'Continue' button. It is the responsibility of the developer to ensure that the warning
 *  is not triggered a second time if the user chooses to continue.
 */
OO.ui.Error = function OoUiError( message, config ) {
	// Allow passing positional parameters inside the config object
	if ( OO.isPlainObject( message ) && config === undefined ) {
		config = message;
		message = config.message;
	}

	// Configuration initialization
	config = config || {};

	// Properties
	this.message = message instanceof jQuery ? message : String( message );
	this.recoverable = config.recoverable === undefined || !!config.recoverable;
	this.warning = !!config.warning;
};

/* Setup */

OO.initClass( OO.ui.Error );

/* Methods */

/**
 * Check if the error is recoverable.
 *
 * If the error is recoverable, users are able to try the process again.
 *
 * @return {boolean} Error is recoverable
 */
OO.ui.Error.prototype.isRecoverable = function () {
	return this.recoverable;
};

/**
 * Check if the error is a warning.
 *
 * If the error is a warning, the error interface will include a 'Dismiss' and a 'Continue' button.
 *
 * @return {boolean} Error is warning
 */
OO.ui.Error.prototype.isWarning = function () {
	return this.warning;
};

/**
 * Get error message as DOM nodes.
 *
 * @return {jQuery} Error message in DOM nodes
 */
OO.ui.Error.prototype.getMessage = function () {
	return this.message instanceof jQuery ?
		this.message.clone() :
		$( '<div>' ).text( this.message ).contents();
};

/**
 * Get the error message text.
 *
 * @return {string} Error message
 */
OO.ui.Error.prototype.getMessageText = function () {
	return this.message instanceof jQuery ? this.message.text() : this.message;
};
