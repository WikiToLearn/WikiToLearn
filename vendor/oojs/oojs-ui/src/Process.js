/**
 * A Process is a list of steps that are called in sequence. The step can be a number, a jQuery promise,
 * or a function:
 *
 * - **number**: the process will wait for the specified number of milliseconds before proceeding.
 * - **promise**: the process will continue to the next step when the promise is successfully resolved
 *  or stop if the promise is rejected.
 * - **function**: the process will execute the function. The process will stop if the function returns
 *  either a boolean `false` or a promise that is rejected; if the function returns a number, the process
 *  will wait for that number of milliseconds before proceeding.
 *
 * If the process fails, an {@link OO.ui.Error error} is generated. Depending on how the error is
 * configured, users can dismiss the error and try the process again, or not. If a process is stopped,
 * its remaining steps will not be performed.
 *
 * @class
 *
 * @constructor
 * @param {number|jQuery.Promise|Function} step Number of miliseconds to wait before proceeding, promise
 *  that must be resolved before proceeding, or a function to execute. See #createStep for more information. see #createStep for more information
 * @param {Object} [context=null] Execution context of the function. The context is ignored if the step is
 *  a number or promise.
 * @return {Object} Step object, with `callback` and `context` properties
 */
OO.ui.Process = function ( step, context ) {
	// Properties
	this.steps = [];

	// Initialization
	if ( step !== undefined ) {
		this.next( step, context );
	}
};

/* Setup */

OO.initClass( OO.ui.Process );

/* Methods */

/**
 * Start the process.
 *
 * @return {jQuery.Promise} Promise that is resolved when all steps have successfully completed.
 *  If any of the steps return a promise that is rejected or a boolean false, this promise is rejected
 *  and any remaining steps are not performed.
 */
OO.ui.Process.prototype.execute = function () {
	var i, len, promise;

	/**
	 * Continue execution.
	 *
	 * @ignore
	 * @param {Array} step A function and the context it should be called in
	 * @return {Function} Function that continues the process
	 */
	function proceed( step ) {
		return function () {
			// Execute step in the correct context
			var deferred,
				result = step.callback.call( step.context );

			if ( result === false ) {
				// Use rejected promise for boolean false results
				return $.Deferred().reject( [] ).promise();
			}
			if ( typeof result === 'number' ) {
				if ( result < 0 ) {
					throw new Error( 'Cannot go back in time: flux capacitor is out of service' );
				}
				// Use a delayed promise for numbers, expecting them to be in milliseconds
				deferred = $.Deferred();
				setTimeout( deferred.resolve, result );
				return deferred.promise();
			}
			if ( result instanceof OO.ui.Error ) {
				// Use rejected promise for error
				return $.Deferred().reject( [ result ] ).promise();
			}
			if ( Array.isArray( result ) && result.length && result[ 0 ] instanceof OO.ui.Error ) {
				// Use rejected promise for list of errors
				return $.Deferred().reject( result ).promise();
			}
			// Duck-type the object to see if it can produce a promise
			if ( result && $.isFunction( result.promise ) ) {
				// Use a promise generated from the result
				return result.promise();
			}
			// Use resolved promise for other results
			return $.Deferred().resolve().promise();
		};
	}

	if ( this.steps.length ) {
		// Generate a chain reaction of promises
		promise = proceed( this.steps[ 0 ] )();
		for ( i = 1, len = this.steps.length; i < len; i++ ) {
			promise = promise.then( proceed( this.steps[ i ] ) );
		}
	} else {
		promise = $.Deferred().resolve().promise();
	}

	return promise;
};

/**
 * Create a process step.
 *
 * @private
 * @param {number|jQuery.Promise|Function} step
 *
 * - Number of milliseconds to wait before proceeding
 * - Promise that must be resolved before proceeding
 * - Function to execute
 *   - If the function returns a boolean false the process will stop
 *   - If the function returns a promise, the process will continue to the next
 *     step when the promise is resolved or stop if the promise is rejected
 *   - If the function returns a number, the process will wait for that number of
 *     milliseconds before proceeding
 * @param {Object} [context=null] Execution context of the function. The context is
 *  ignored if the step is a number or promise.
 * @return {Object} Step object, with `callback` and `context` properties
 */
OO.ui.Process.prototype.createStep = function ( step, context ) {
	if ( typeof step === 'number' || $.isFunction( step.promise ) ) {
		return {
			callback: function () {
				return step;
			},
			context: null
		};
	}
	if ( $.isFunction( step ) ) {
		return {
			callback: step,
			context: context
		};
	}
	throw new Error( 'Cannot create process step: number, promise or function expected' );
};

/**
 * Add step to the beginning of the process.
 *
 * @inheritdoc #createStep
 * @return {OO.ui.Process} this
 * @chainable
 */
OO.ui.Process.prototype.first = function ( step, context ) {
	this.steps.unshift( this.createStep( step, context ) );
	return this;
};

/**
 * Add step to the end of the process.
 *
 * @inheritdoc #createStep
 * @return {OO.ui.Process} this
 * @chainable
 */
OO.ui.Process.prototype.next = function ( step, context ) {
	this.steps.push( this.createStep( step, context ) );
	return this;
};
