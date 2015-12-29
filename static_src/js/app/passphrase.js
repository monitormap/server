'use strict';

angular.module('monitormapApp')
	.controller('PassphraseCtrl', ['$scope','$rootScope','socket',function ($scope,$rootScope, socket) {
		$scope.new_passphrase = '*';

		$scope.set = function(){
			$rootScope.passphrase = $scope.new_passphrase;
		}
	}]);
