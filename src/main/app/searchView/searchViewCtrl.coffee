name = 'searchView.searchViewCtrl'

angular.module(name, []).controller(name, [
	'$scope'
	'$log'
	'$location'
	'common.services.dataSvc'
	'common.services.toastrWrapperSvc'
	($scope, $log, $location, data, tstr) ->

		$scope.people = data.getPeople()

		$scope.loadDetails = (personId) ->
			person = data.getPerson(personId)
			tstr.info("You've selected '#{person.firstName} #{person.lastName}'")
			$location.path("details/#{personId}")
	])