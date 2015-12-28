'use strict';

angular.module('monitormapApp')
	.config(['$stateProvider',function ($stateProvider) {
		$stateProvider
			.state('list', {
				url:'/list',
				templateUrl: 'app/list.html',
				controller:'ListCtrl'
			})
	}]);
