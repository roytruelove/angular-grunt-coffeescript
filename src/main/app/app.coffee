### ###########################################################################
# Wire modules together
### ###########################################################################

mods = [

  'common.directives.glowGreenOnMouseoverDirective'
  'common.directives.uiTooltipDirective'
  'common.filters.toLowerFilter'
  'common.services.dataSvc'
  'common.services.envProvider'
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

m.config (['common.services.envProvider', (envProvider)->

  # Allows the environment provider to run whatever config block it wants.
  if envProvider.appConfig?
    envProvider.appConfig()
])

m.run (['common.services.env', (env)->

  # Allows the environment service to run whatever app run block it wants.
  if env.appRun?
    env.appRun()
])

angular.element(document).ready ()->
  angular.bootstrap(document,['app'])
