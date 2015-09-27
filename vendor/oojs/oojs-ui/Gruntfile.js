/*!
 * Grunt file
 */

/*jshint node:true */
module.exports = function ( grunt ) {
	grunt.loadNpmTasks( 'grunt-banana-checker' );
	grunt.loadNpmTasks( 'grunt-contrib-clean' );
	grunt.loadNpmTasks( 'grunt-contrib-concat-sourcemaps' );
	grunt.loadNpmTasks( 'grunt-contrib-copy' );
	grunt.loadNpmTasks( 'grunt-contrib-csslint' );
	grunt.loadNpmTasks( 'grunt-contrib-cssmin' );
	grunt.loadNpmTasks( 'grunt-contrib-jshint' );
	grunt.loadNpmTasks( 'grunt-contrib-less' );
	grunt.loadNpmTasks( 'grunt-contrib-uglify' );
	grunt.loadNpmTasks( 'grunt-contrib-watch' );
	grunt.loadNpmTasks( 'grunt-csscomb' );
	grunt.loadNpmTasks( 'grunt-exec' );
	grunt.loadNpmTasks( 'grunt-file-exists' );
	grunt.loadNpmTasks( 'grunt-cssjanus' );
	grunt.loadNpmTasks( 'grunt-jscs' );
	grunt.loadNpmTasks( 'grunt-karma' );
	grunt.loadNpmTasks( 'grunt-svg2png' );
	grunt.loadTasks( 'build/tasks' );

	var modules = grunt.file.readJSON( 'build/modules.json' ),
		pgk = grunt.file.readJSON( 'package.json' ),
		lessFiles = {
			raster: {},
			vector: {},
			mixed: {}
		},
		colorizeSvgFiles = {},
		requiredFiles = modules[ 'oojs-ui' ].scripts.slice(),
		concatCssFiles = {},
		rtlFiles = {},
		minBanner = '/*! OOjs UI v<%= pkg.version %> | http://oojs.mit-license.org */';

	( function () {
		var distFile, target, module, moduleStyleFiles;
		function rtlPath( fileName ) {
			return fileName.replace( /\.(\w+)$/, '.rtl.$1' );
		}
		// Generate all task targets required to process given file into a pair of CSS files (for LTR
		// and RTL), and return file name of LTR file.
		function processFile( fileName ) {
			var lessFileName, cssFileName, theme, path;
			path = require( 'path' );
			if ( path.extname( fileName ) === '.json' ) {
				lessFileName = fileName.replace( /\.json$/, '.less' ).replace( /^src/, 'dist/tmp' );
				theme = path.basename( path.dirname( fileName ) );

				colorizeSvgFiles[ fileName.replace( /.+\/(\w+)\/([\w-]+)\.(?:json|less)$/, '$1-$2' ) ] = {
					options: grunt.file.readJSON( fileName ),
					srcDir: 'src/themes/' + theme,
					destDir: 'dist/themes/' + theme,
					// This should not be needed, but our dist directory structure is weird
					cssPrependPath: 'themes/' + theme + '/',
					destLessFile: {
						ltr: lessFileName,
						rtl: rtlPath( lessFileName )
					}
				};

				cssFileName = fileName.replace( /\.json$/, '.css' ).replace( /^src/, 'dist/tmp/' + target );
				lessFiles[ target ][ cssFileName ] = [ lessFileName ];
				lessFiles[ target ][ rtlPath( cssFileName ) ] = [ rtlPath( lessFileName ) ];
			} else {
				cssFileName = fileName.replace( /\.less$/, '.css' ).replace( /^src/, 'dist/tmp/' + target );
				lessFiles[ target ][ cssFileName ] = [ fileName ];
				rtlFiles[ rtlPath( cssFileName ) ] = cssFileName;
			}
			return cssFileName;
		}
		for ( module in modules ) {
			if ( modules[ module ].styles ) {
				moduleStyleFiles = modules[ module ].styles;
				for ( target in lessFiles ) {
					requiredFiles.push.apply( requiredFiles, moduleStyleFiles );

					distFile = 'dist/' + module + ( target !== 'mixed' ? '.' + target : '' ) + '.css';

					concatCssFiles[ distFile ] = moduleStyleFiles.map( processFile );
					concatCssFiles[ rtlPath( distFile ) ] = concatCssFiles[ distFile ].map( rtlPath );
				}
			}
		}
	}() );

	function strip( str ) {
		var path = require( 'path' );
		// http://gruntjs.com/configuring-tasks#building-the-files-object-dynamically
		// http://gruntjs.com/api/grunt.file#grunt.file.expandmapping
		return function ( dest, src ) {
			return path.join( dest, src.replace( str, '' ) );
		};
	}

	grunt.initConfig( {
		pkg: pgk,

		// Build
		clean: {
			build: 'dist/*',
			doc: 'docs/*',
			tmp: 'dist/tmp'
		},
		fileExists: {
			src: requiredFiles
		},
		typos: {
			options: {
				typos: 'build/typos.json'
			},
			src: '{src,php}/**/*.{js,json,less,css}'
		},
		concat: {
			options: {
				banner: grunt.file.read( 'build/banner.txt' )
			},
			js: {
				files: {
					'dist/oojs-ui.js': modules[ 'oojs-ui' ].scripts,
					'dist/oojs-ui-apex.js': modules[ 'oojs-ui-apex' ].scripts,
					'dist/oojs-ui-mediawiki.js': modules[ 'oojs-ui-mediawiki' ].scripts
				}
			},
			css: {
				files: concatCssFiles
			},
			demoCss: {
				options: {
					banner: '/** This file is generated automatically. Do not modify it. */\n\n'
				},
				files: {
					'demos/styles/demo.rtl.css': 'demos/styles/demo.rtl.css'
				}
			}
		},

		// Build – Code
		uglify: {
			options: {
				banner: minBanner,
				sourceMap: true,
				sourceMapIncludeSources: true,
				report: 'gzip'
			},
			js: {
				expand: true,
				src: 'dist/*.js',
				ext: '.min.js',
				extDot: 'last'
			}
		},

		// Build – Styling
		less: {
			distRaster: {
				options: {
					ieCompat: true,
					report: 'gzip',
					modifyVars: {
						'oo-ui-distribution': 'raster',
						'oo-ui-default-image-ext': 'png'
					}
				},
				files: lessFiles.raster
			},
			distVector: {
				options: {
					ieCompat: false,
					report: 'gzip',
					modifyVars: {
						'oo-ui-distribution': 'vector',
						'oo-ui-default-image-ext': 'svg'
					}
				},
				files: lessFiles.vector
			},
			distMixed: {
				options: {
					ieCompat: false,
					report: 'gzip',
					modifyVars: {
						'oo-ui-distribution': 'mixed',
						'oo-ui-default-image-ext': 'png'
					}
				},
				files: lessFiles.mixed
			}
		},
		cssjanus: {
			options: {
				generateExactDuplicates: true
			},
			dist: {
				files: rtlFiles
			},
			demoCss: {
				files: {
					'demos/styles/demo.rtl.css': 'demos/styles/demo.css'
				}
			}
		},
		csscomb: {
			dist: {
				expand: true,
				src: 'dist/*.css'
			}
		},
		copy: {
			imagesCommon: {
				src: 'src/styles/images/*.cur',
				dest: 'dist/images/',
				expand: true,
				flatten: true
			},
			imagesApex: {
				src: 'src/themes/apex/images/**/*.{png,gif}',
				dest: 'dist/themes/apex/images/',
				expand: true,
				rename: strip( 'src/themes/apex/images/' )
			},
			imagesMediaWiki: {
				src: 'src/themes/mediawiki/images/**/*.{png,gif}',
				dest: 'dist/themes/mediawiki/images/',
				expand: true,
				rename: strip( 'src/themes/mediawiki/images/' )
			},
			i18n: {
				src: 'i18n/*.json',
				expand: true,
				dest: 'dist/'
			},
			jsduck: {
				// Don't publish devDependencies
				src: '{dist,node_modules/{' + Object.keys( pgk.dependencies ).join( ',' ) + '}}/**/*',
				dest: 'docs/',
				expand: true
			}
		},
		colorizeSvg: colorizeSvgFiles,
		svg2png: {
			dist: {
				src: 'dist/{images,themes}/**/*.svg'
			}
		},
		cssmin: {
			options: {
				keepSpecialComments: 0,
				banner: minBanner,
				compatibility: 'ie8',
				report: 'gzip'
			},
			dist: {
				expand: true,
				src: 'dist/*.css',
				ext: '.min.css',
				extDot: 'last'
			}
		},

		// Lint – Code
		jshint: {
			options: {
				jshintrc: true
			},
			dev: [
				'*.js',
				'{build,demos,src,tests}/**/*.js',
				'!tests/JSPHP.test.js'
			]
		},
		jscs: {
			dev: [
				'<%= jshint.dev %>',
				'!demos/dist/**'
			]
		},

		// Lint – Styling
		csslint: {
			options: {
				csslintrc: '.csslintrc'
			},
			all: [
				'{demos,src}/**/*.css',
				'!demos/dist/**'
			]
		},

		// Lint – i18n
		banana: {
			all: 'i18n/'
		},

		// Test
		exec: {
			rubyTestSuiteGenerator: {
				command: 'ruby bin/testsuitegenerator.rb src php > tests/JSPHP-suite.json'
			},
			phpGenerateJSPHPForKarma: {
				command: 'php ../bin/generate-JSPHP-for-karma.php > JSPHP.test.js',
				cwd: './tests'
			}
		},
		karma: {
			options: {
				frameworks: [ 'qunit' ],
				files: [
					'node_modules/jquery/dist/jquery.js',
					'node_modules/oojs/dist/oojs.jquery.js',
					'dist/oojs-ui.js',
					'dist/oojs-ui-apex.js',
					'dist/oojs-ui-mediawiki.js',
					'tests/QUnit.assert.equalDomElement.js',
					'tests/**/*.test.js'
				],
				reporters: [ 'dots' ],
				singleRun: true,
				browserDisconnectTimeout: 5000,
				browserDisconnectTolerance: 2,
				autoWatch: false
			},
			main: {
				browsers: [ 'Chrome' ],
				preprocessors: {
					'dist/*.js': [ 'coverage' ]
				},
				reporters: [ 'dots', 'coverage' ],
				coverageReporter: { reporters: [
					{ type: 'html', dir: 'coverage/' },
					{ type: 'text-summary', dir: 'coverage/' }
				] }
			},
			other: {
				browsers: [ 'Firefox' ]
			}
		},

		// Development
		watch: {
			files: [
				'<%= jshint.dev %>',
				'<%= csslint.all %>',
				'{demos,src}/**/*.less',
				'.{csslintrc,jscsrc,jshintignore,jshintrc}'
			],
			tasks: 'quick-build'
		}
	} );

	grunt.registerTask( 'pre-test', function () {
		// Only create Source maps when doing a git-build for testing and local
		// development. Distributions for export should not, as the map would
		// be pointing at "../src".
		grunt.config.set( 'concat.js.options.sourceMap', true );
		grunt.config.set( 'concat.js.options.sourceMapStyle', 'link' );
	} );

	grunt.registerTask( 'pre-git-build', function () {
		var done = this.async();
		require( 'child_process' ).exec( 'git rev-parse HEAD', function ( err, stout, stderr ) {
			if ( !stout || err || stderr ) {
				grunt.log.err( err || stderr );
				done( false );
				return;
			}
			grunt.config.set( 'pkg.version', grunt.config( 'pkg.version' ) + '-pre (' + stout.slice( 0, 10 ) + ')' );
			grunt.verbose.writeln( 'Added git HEAD to pgk.version' );
			done();
		} );
	} );

	grunt.registerTask( 'build-code', [ 'concat:js', 'uglify' ] );
	grunt.registerTask( 'build-styling', [
		'colorizeSvg', 'less', 'cssjanus',
		'concat:css', 'concat:demoCss', 'csscomb', 'cssmin',
		'copy:imagesCommon', 'copy:imagesApex', 'copy:imagesMediaWiki', 'svg2png'
	] );
	grunt.registerTask( 'build-i18n', [ 'copy:i18n' ] );
	grunt.registerTask( 'build-tests', [ 'exec:rubyTestSuiteGenerator', 'exec:phpGenerateJSPHPForKarma' ] );
	grunt.registerTask( 'build', [ 'clean:build', 'fileExists', 'typos', 'build-code', 'build-styling', 'build-i18n', 'build-tests', 'clean:tmp' ] );

	grunt.registerTask( 'git-build', [ 'pre-git-build', 'build' ] );

	// Quickly build a no-frills vector-only ltr-only version for development
	grunt.registerTask( 'quick-build', [
		'pre-git-build', 'clean:build', 'fileExists', 'typos',
		'concat:js',
		'colorizeSvg', 'less:distVector', 'concat:css',
		'copy:imagesCommon', 'copy:imagesApex', 'copy:imagesMediaWiki',
		'build-i18n'
	] );

	grunt.registerTask( 'lint', [ 'jshint', 'jscs', 'csslint', 'banana' ] );
	grunt.registerTask( 'test', [ 'lint', 'pre-test', 'git-build', 'karma:main', 'karma:other' ] );

	grunt.registerTask( 'default', 'test' );
};
