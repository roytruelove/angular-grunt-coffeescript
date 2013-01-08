name = 'common.services.harcodedDataSvc'

class HardCodedData

	people: [
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

	###
	Builds an 'ok' response for the 'respond' method
	###
	buildOkResp: (data) ->
		return [200, data, {}]

	addHardcodedData: ($httpBackend) ->

		$httpBackend.whenGET(/html$/).passThrough() # all html can pass

		$httpBackend.whenGET('/people').respond @people

		personRE = /\/person\/(\d+)/
		$httpBackend.whenGET(personRE).respond (method, url, data)=>
			id = parseInt(personRE.exec(url)[1])
			@buildOkResp (person for person in @people when person.id == id)[0]


angular.module(name, []).factory(name, () ->
	new HardCodedData()
)