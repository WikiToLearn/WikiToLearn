/*!
 * A QUnit assertion to compare DOM node trees.
 *
 * Adapted from VisualEditor plugin for QUnit. Additionally supports comparing properties to
 * attributes (for dynamically generated nodes) and order-insensitive comparison of classes on DOM
 * nodes.
 *
 * @copyright 2011-2015 VisualEditor Team and others; see http://ve.mit-license.org
 * @copyright 2011-2015 OOjs Team and other contributors
 */

( function ( QUnit ) {

	/**
	 * Build a summary of an HTML element.
	 *
	 * Summaries include node name, text, attributes and recursive summaries of children.
	 * Used for serializing or comparing HTML elements.
	 *
	 * @private
	 * @param {HTMLElement} element Element to summarize
	 * @param {boolean} [includeHtml=false] Include an HTML summary for element nodes
	 * @return {Object} Summary of element.
	 */
	function getDomElementSummary( element, includeHtml ) {
		var i, name,
			summary = {
				type: element.nodeName.toLowerCase(),
				// $( '<div><textarea>Foo</textarea></div>' )[0].textContent === 'Foo', which breaks
				// comparisons :( childNodes are summarized anyway, this would just be a nicety
				// text: element.textContent,
				attributes: {},
				children: []
			};

		if ( includeHtml && element.nodeType === Node.ELEMENT_NODE ) {
			summary.html = element.outerHTML;
		}

		// Gather attributes
		if ( element.attributes ) {
			for ( i = 0; i < element.attributes.length; i++ ) {
				name = element.attributes[ i ].name;
				if ( name.substr( 0, 5 ) !== 'data-' && name !== 'id' ) {
					summary.attributes[ name ] = element.attributes[ i ].value;
				}
			}
		}

		// Sort classes
		if ( summary.attributes.class ) {
			summary.attributes.class = summary.attributes.class.split( ' ' ).sort().join( ' ' );
		}

		// Gather certain properties and pretend they are attributes.
		// Take note of casing differences.
		if ( element.value !== undefined ) {
			summary.attributes.value = element.value;
		}
		if ( element.readOnly !== undefined ) {
			summary.attributes.readonly = element.readOnly;
		}
		if ( element.checked !== undefined ) {
			summary.attributes.checked = element.checked;
		}
		if ( element.disabled !== undefined ) {
			summary.attributes.disabled = element.disabled;
		}
		if ( element.tabIndex !== undefined ) {
			summary.attributes.tabindex = element.tabIndex;
		}

		// Summarize children
		if ( element.childNodes ) {
			for ( i = 0; i < element.childNodes.length; i++ ) {
				summary.children.push( getDomElementSummary( element.childNodes[ i ], includeHtml ) );
			}
		}

		// Special handling for textareas, where we only want to account for the content as the 'value'
		// property, never as childNodes or textContent
		if ( summary.type === 'textarea' ) {
			// summary.text = '';
			summary.children = [];
		}

		return summary;
	}

	/**
	 * @method
	 * @static
	 */
	QUnit.assert.equalDomElement = function ( actual, expected, message, stringify ) {
		var actualSummary = getDomElementSummary( actual ),
			expectedSummary = getDomElementSummary( expected ),
			actualSummaryHtml = getDomElementSummary( actual, true ),
			expectedSummaryHtml = getDomElementSummary( expected, true );

		// When running with Karma, the objects are not nicely stringified in the output when the test
		// fails, only showing "Expected: [object Object], Actual: [object Object]" instead. Running
		// QUnit in browser does this, and stringifying causes double escaping in output.
		if ( stringify ) {
			actualSummaryHtml = JSON.stringify( actualSummaryHtml, null, 2 );
			expectedSummaryHtml = JSON.stringify( expectedSummaryHtml, null, 2 );
		}

		QUnit.push(
			QUnit.equiv( actualSummary, expectedSummary ), actualSummaryHtml, expectedSummaryHtml, message
		);
	};

}( QUnit ) );
