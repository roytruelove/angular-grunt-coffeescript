name = 'index.indexCtrl'

angular.module(name, []).controller(name, [
	'$log',
	'$scope',
	'common.services.env'
	($log, $scope, env) ->
		$log.log("Initializing the index controller")
		$log.log(env)
	])