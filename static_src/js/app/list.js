'use strict';

angular.module('monitormapApp')
	.controller('ListCtrl', ['$scope','socket',function ($scope, socket) {
		$scope.list = [];
		socket.emit('node:list',function(result){
			$scope.list = result.list;
		});
	}]);
