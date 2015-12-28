'use strict';

angular.module('monitormapApp')
	.config(['$stateProvider',function ($stateProvider) {
		$stateProvider
			.state('list', {
				url:'/list',
				templateUrl: 'app/list.html',
				controller:'ListCtrl'
			})
			.state('new', {
				url:'/new',
				templateUrl: 'app/list.html',
				controller:'NewCtrl'
			})
	}]);
