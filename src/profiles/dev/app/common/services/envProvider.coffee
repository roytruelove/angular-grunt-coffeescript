###
DEV
###
providerName = 'common.services.env' # angular adds the 'Provider' suffix for us.
modName = "#{providerName}Provider"

class Environment

	env: 'DEV'
	serverUrl: '' # blank because all $http calls will be faked

	constructor: (@$httpBackend, @hardcodedData)->

	appRun: ()->
		@hardcodedData.addHardcodedData(@$httpBackend)

class EnvironmentProvider

	$get: 
		[
			'$httpBackend'
			'common.services.harcodedDataSvc'
			($httpBackend, hardcodedData)->
				new Environment($httpBackend, hardcodedData)
		]

	appConfig: ()->
		# no config-level changes

# note that we have to include the module names of our dependencies here since the main app
# modules won't know about them
mod = angular.module(modName, ['ngMockE2E', 'common.services.harcodedDataSvc'])
mod.provider(providerName, new EnvironmentProvider())
