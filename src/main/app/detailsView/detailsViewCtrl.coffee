name = 'detailsView.detailsViewCtrl'

angular.module(name, []).controller(name, [
	'$scope'
	'$log'
	'$routeParams'
	'common.services.dataSvc'
	($scope, $log, $routeParams, data) ->

		personId = parseInt($routeParams.id)

		data.getPerson(personId).then (resp)->
			$scope.person = resp.data
	])