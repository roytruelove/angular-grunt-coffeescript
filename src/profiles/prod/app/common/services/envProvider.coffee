###
PROD
###
providerName = 'common.services.env' # angular adds the 'Provider' suffix for us.
modName = "#{providerName}Provider"

class Environment

	env: 'PROD'
	serverUrl: 'http://someProductionURL:8080'

class EnvironmentProvider

	$get: ()->
		new Environment()

mod = angular.module(modName, [])
mod.provider(providerName, new EnvironmentProvider())
