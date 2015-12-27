'use strict';
module.exports = function (grunt) {
	require('jit-grunt')(grunt, {
		useminPrepare: 'grunt-usemin',
		injector: 'grunt-asset-injector',
		buildcontrol: 'grunt-build-control',
		nggettext_extract: 'grunt-angular-gettext',
		nggettext_compile: 'grunt-angular-gettext'
	});
	require('time-grunt')(grunt);
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		clean: {dist:['.tmp','static']},
		wiredep: {
			target: {src: ['static/*.html']}
		},
		jade: {
			compile: {
				options: {
					data: {debug: false},
					pretty:true
				},
				files: [{
					expand: true,
					cwd: 'views',
					src: ['**/*.jade'],
					dest: 'static',
					ext: '.html'
				}]
			}
		},
		useminPrepare: {
			html: ['static/index.html']
		},
		injector:{
			css:{
				options: {
					destFile : 'static/index.html',
					ignorePath: 'static_src',
					starttag: '<!-- injector:css-->',
					endtag: '<!-- endinjector-->'
				},
				files: [{
					expand: true,
					cwd: 'static_src/',
					src: ['**/*.css','!deps/**/*.css'],
					ext: '.css'
				}]
			},
			scripts: {
				options: {
					destFile : 'static/index.html',
					ignorePath: 'static_src',
					starttag: '<!-- injector:js-->',
					endtag: '<!-- endinjector-->'
				},
				files: [{
					expand: true,
					cwd: 'static_src/',
					src: ['**/*.js','!deps/**/*.js'],
					ext: '.js'
				}]
			}
		},
		copy:{
			dist:{
				files:[{
					expand: true,
					dot: true,
					dest:'static',
					cwd:'static_src',
					src:['**/*.{png,jpg}','!deps/**/*']
				}]
			}
		},
		uglify: {
			'static/app.js': [ '.tmp/concat/app.js' ],
			'static/vendor.js': [ '.tmp/concat/vendor.js' ]
		},
		cssmin: {
			'static/app.css': [ '.tmp/concat/app.css' ],
			'static/vendor.css': [ '.tmp/concat/vendor.css' ]
		},
		usemin: {
			html: ['static/*.html'],
			css: ['static/*.css'],
			js: ['static/*.js'],
		}
	});
	grunt.registerTask('default', [
		'clean:dist',
		'jade',
		'wiredep',
		'injector:css',
		'injector:scripts',
		'useminPrepare',
		'concat',
		'copy:dist',
		'cssmin',
		'uglify',
		'usemin',
	]);
};
