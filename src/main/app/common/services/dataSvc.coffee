###
Example of a service shared across views.
Wrapper around the data layer for the app. 
###
name = 'common.services.dataSvc'

class DataSvc

	constructor: (@$log, @$http, @env) ->

	_get: (relPath)->
		return @$http.get("#{@env.serverUrl}/#{relPath}")

	getPeople: () ->
		return @_get('people')

	getPerson: (id) ->
		return @_get("person/#{id}")

angular.module(name, []).factory(name, ['$log','$http', 'common.services.env', ($log, $http, env) ->
	new DataSvc($log, $http, env)
])