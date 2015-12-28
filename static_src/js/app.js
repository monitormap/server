'use strict';

'use strict';

angular.module('monitormapApp', [
	'ui.router',
	'btford.socket-io',
	'leaflet-directive',
	'tableSort'
])
	.config(['$urlRouterProvider','$locationProvider',function ($urlRouterProvider, $locationProvider) {
		$urlRouterProvider.otherwise('/');
	}])
	.factory('socket', function (socketFactory) {
		return socketFactory({
			prefix: '',
			ioSocket: io.connect('http://localhost:8080',{path:'/ws'})
		});
	});
