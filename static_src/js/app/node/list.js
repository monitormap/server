'use strict';

angular.module('monitormapApp')
	.controller('ListCtrl', ['$scope','$rootScope','socket',function ($scope, $rootScope,socket) {
		$scope.list = [];
		socket.emit('node:list',function(result){
			$scope.list = result.list;
		});
		$scope.status = function(a){
			if(new Date(a) > new Date(new Date() - 5*60*1000 ))
				return true
			return false
		}
		$scope.count = function(a){
			var c=0;
			if($scope.list){
				for(var i=0; i< $scope.list.length;i++){
					c+=$scope.list[i][a];
				}
			}
			return c;
		}
		$scope.set = function(obj){
			socket.emit('node:set',$rootScope.passphrase,obj,function(result){
			})
		}
	}]);
