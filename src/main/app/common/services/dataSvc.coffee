###
Example of a service shared across views.
Wrapper around the data layer for the app.  Hardcoded for testing purposes.
###
name = 'common.services.dataSvc'

class DataSvc

	constructor: (@$log) ->
		@hardcodedData = [
			{
				id: 1
				firstName: 'Jacob'
				lastName: 'Kent'
			}
			{
				id: 2
				firstName: 'Emily'
				lastName: 'Wythe'
			}
			{
				id: 3
				firstName: 'Michael'
				lastName: 'Berry'
			}
			{
				id: 4
				firstName: 'Madison'
				lastName: 'Bedford'
			}
			{
				id: 5
				firstName: 'Matthew'
				lastName: 'Driggs'
			}
			{
				id: 6
				firstName: 'Hannah'
				lastName: 'Roebling'
			}
			{
				id: 7
				firstName: 'Joshua'
				lastName: 'Havemeyer'
			}
		]

	getPeople: () ->
		return @hardcodedData

	getPerson: (id) ->
		# inefficient but good enough for a demo
		return person for person in @hardcodedData when person.id == id

angular.module(name, []).factory(name, ['$log', ($log) ->
	new DataSvc($log)
])



