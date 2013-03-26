name = 'searchView.searchViewCtrl'

angular.module(name, []).controller(name, [
	'$scope'
	'$log'
	'$location'
	'common.services.dataSvc'
	'common.services.toastrWrapperSvc'
	($scope, $log, $location, data, tstr) ->

		data.getPeople().then (resp)->
			$scope.people = resp.data

		$scope.loadDetails = (personId) ->

			if (personId == 6)
				tstr.error("Hannah always throws this error just to show toastr integration.", "Fake Error!")
				return

			$location.path("details/#{personId}")
	])