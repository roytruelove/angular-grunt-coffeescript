### ###########################################################################
# Wire modules together
### ###########################################################################

mods = [

	'common.directives.glowGreenOnMouseoverDirective'
	'common.directives.uiTooltipDirective'
	'common.filters.toLowerFilter'
	'common.services.dataSvc'
	'common.services.toastrWrapperSvc'

	'detailsView.detailsViewCtrl'
	'detailsView.mattizerFilter'
	'detailsView.personDetailsDirective'

	'index.indexCtrl'

	'searchView.searchViewCtrl'
]

### ###########################################################################
# Declare routes 
### ###########################################################################

routes = ($routeProvider)->

	$routeProvider.when('/search',
			{templateUrl: 'searchView/searchView.html'})
	$routeProvider.when('/details/:id',
			{templateUrl: 'detailsView/detailsView.html'})

	$routeProvider.otherwise({redirectTo: '/search'})

### ###########################################################################
# Create and bootstrap app module
### ###########################################################################

angular
	.module('app', mods)
	.config ['$routeProvider', routes]

	angular.element(document).ready ()->
		angular.bootstrap(document,['app'])