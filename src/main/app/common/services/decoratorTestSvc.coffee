###
Example of a service shared across views.
Wrapper around the data layer for the app.  Hardcoded for testing purposes.
###
name = 'common.services.decoratorTestSvc'

class DecoratorTest

	constructor: (@$log, @data) ->
		$log.log("Created Decorator Test")
	getSomeData: () ->
		@data.getPerson(1)

angular.module(name, []).factory(name, ['$log', 'common.services.dataSvc', ($log, data) ->
	new DecoratorTest($log, data)
])
