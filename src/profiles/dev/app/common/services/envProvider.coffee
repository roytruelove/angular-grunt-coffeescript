###
DEV
###
providerName = 'common.services.env'
# angular adds the 'Provider' suffix for us.
modName = "#{providerName}Provider"

class Environment

  env: 'DEV'
  serverUrl: '' # blank because all $http calls will be faked

  constructor: (@$httpBackend, @$log, @hardcodedData)->

  appRun: ()->
    @$log.log ("Running custom 'run'-time initialization
      of the main app module")
    @hardcodedData.addHardcodedData(@$httpBackend)

class EnvironmentProvider

  $get:
    [
      '$httpBackend'
      '$log'
      'common.services.harcodedDataSvc'
      ($httpBackend, $log, hardcodedData)->
        new Environment($httpBackend, $log, hardcodedData)
    ]

  appConfig: ()->
    # using console because there's no 'log' object yet
    console.log("Running custom 'config'-time initialization
      of the main app module")

# note that we have to include the module
#  names of our dependencies here since the main app
# modules won't know about them
mod = angular.module(modName, ['ngMockE2E', 'common.services.harcodedDataSvc'])
mod.provider(providerName, new EnvironmentProvider())
