'use strict';

angular.module('monitormapApp')
	.controller('NewCtrl', ['$scope','socket',function ($scope, socket) {
		$scope.list = [];
		socket.on('event::node:set:create',function(result){
			$scope.list.push(result)
		});
	}]);
