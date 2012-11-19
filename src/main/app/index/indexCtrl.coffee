name = 'index.indexCtrl'

angular.module(name, []).controller(name, [
	'$log',
	'$scope',
	'common.services.env'
	($log, $scope, envSvc) ->

		$scope.env = envSvc.env
		
	])