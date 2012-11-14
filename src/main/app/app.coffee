### ###########################################################################
# Wire modules together
### ###########################################################################

mods = [

	'common.directives.glowGreenOnMouseoverDirective'
	'common.directives.uiTooltipDirective'
	'common.filters.toLowerFilter'
	'common.services.dataSvc'
	'common.services.decoratorTestSvc'  # TODO testing only
	'common.services.envProvider'		# TODO testing only
	'common.services.toastrWrapperSvc'

	'detailsView.detailsViewCtrl'
	'detailsView.personDetailsDirective'

	'index.indexCtrl'

	'searchView.mattizerFilter'
	'searchView.searchViewCtrl'
]

### ###########################################################################
# Declare routes 
### ###########################################################################

routesConfigFn = ($routeProvider)->

	$routeProvider.when('/search',
			{templateUrl: 'searchView/searchView.html'})
	$routeProvider.when('/details/:id',
			{templateUrl: 'detailsView/detailsView.html'})

	$routeProvider.otherwise({redirectTo: '/search'})

### ###########################################################################
# Create and bootstrap app module
### ###########################################################################
	
m = angular.module('app', mods)
m.config ['$routeProvider', routesConfigFn]
m.config (['$provide', 'common.services.envProvider', ($provide, envProvider)->
	console.log "Configing:"
	console.log envProvider.$get()
	$provide.decorator('common.services.decoratorTestSvc', ($delegate)->
		###
		$delegate.getSomeData = ()-> 
			"Decorated data"
		###
		console.log "decorating"
		return $delegate
	)
])
m.run ()->
	console.log "Running"

angular.element(document).ready ()->
	angular.bootstrap(document,['app'])