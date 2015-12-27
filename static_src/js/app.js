angular.module('monitormapApp', [
		'ui.router',
		'btford.socket-io',
		'leaflet-directive'
	])
	.factory('socket', function (socketFactory) {
		return socketFactory(
			prefix: '',
			ioSocket: io.connect({path:'/ws'})
		)
	})
	.controller('MainCtrl',['$scope', '$http', function($scope, $http) {
		$scope.list = []

	}])
