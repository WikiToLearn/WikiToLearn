/*!
 * Check files from 'src' for typos; fail if any are found.
 */

/*jshint node:true */
module.exports = function ( grunt ) {

	grunt.registerMultiTask( 'typos', function () {
		var typosData, typosCSRegExp, typosCIRegExp, file,
			options = this.options( {
				typos: 'typos.json'
			} ),
			files = this.filesSrc,
			fileCount = files.length,
			typosJSON = grunt.file.read( options.typos ),
			typoCount = 0,
			ok = true;

		try {
			typosData = JSON.parse( typosJSON );
		} catch ( e ) {
			grunt.log.error( 'Could not parse ' + options.typos + ': ' + e );
		}

		typosData.caseSensitive = typosData.caseSensitive || [];
		typosData.caseInsensitive = typosData.caseInsensitive || [];

		typoCount += typosData.caseSensitive.length + typosData.caseInsensitive.length;

		function patternMap( typo ) {
			return typo[ 0 ];
		}

		if ( typosData.caseSensitive.length ) {
			typosCSRegExp = new RegExp(
				'(' + typosData.caseSensitive.map( patternMap ).join( '|' )  + ')', 'g'
			);
		}

		if ( typosData.caseInsensitive.length ) {
			typosCIRegExp = new RegExp(
				'(' + typosData.caseInsensitive.map( patternMap ).join( '|' )  + ')', 'gi'
			);
		}

		function findTypo( line, lineNumber, filepath, typos, flags ) {
			// Check each pattern to find the replacement
			typos.forEach( function ( typo ) {
				var replace,
					pattern = new RegExp( typo[ 0 ], flags ),
					matches = line.match( pattern );

				if ( matches ) {
					ok = false;
					replace = matches[ 0 ].replace( pattern, typo[ 1 ], flags );
					grunt.log.error(
						'File "' + filepath + '" contains typo "' + matches[ 0 ] + '" on line ' + lineNumber +
						', did you mean "' + replace + '"?'
					);
				}
			} );
		}

		files.forEach( function ( filepath ) {
			if ( grunt.file.isDir( filepath ) ) {
				fileCount--;
				return;
			}
			file = grunt.file.read( filepath );
			file.split( '\n' ).forEach( function ( line, lineNumber ) {
				// Check for any typos on the line with group expressions
				if ( typosCSRegExp && typosCSRegExp.test( line ) ) {
					findTypo( line, lineNumber, filepath, typosData.caseSensitive, 'g' );
				}
				if ( typosCIRegExp && typosCIRegExp.test( line ) ) {
					findTypo( line, lineNumber, filepath, typosData.caseInsensitive, 'gi' );
				}
			} );
		} );

		if ( !ok ) {
			return false;
		}

		grunt.log.ok( 'No typos found; ' +
			fileCount + ' file' + ( fileCount !== 1 ? 's' : '' ) + ' checked for ' +
			typoCount + ' typo' + ( typoCount !== 1 ? 's' : '' ) + '.' );
	} );
};
