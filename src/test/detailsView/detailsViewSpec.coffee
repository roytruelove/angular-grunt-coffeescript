describe "Details View", () ->

	describe "Controller", () ->

		populateScope = (routeParamsStub, dataStub)->

			ctrl = null
			scope = null

			module('detailsView.detailsViewCtrl')

			# populate 'ctrl' with controller
			inject (['$rootScope', '$controller', '$log',
				($rootScope, $controller, $log) ->

					scope = $rootScope.$new

					# instantiates the controller, which sets the scope
					ctrl = $controller 'detailsView.detailsViewCtrl',
						'$scope': scope
						'$log': $log
						'$routeParams': routeParamsStub
						'common.services.dataSvc': dataStub
			])

			return scope

		it 'sets the person on the scope given the routeParam ID', () ->

			# Setup stubs
			routeParamsStub = jasmine.createSpy('routeParamsStub')
			routeParamsStub.id = 5

			dataStub = jasmine.createSpy('dataStub')
			dataStub.getPerson = (id) ->
				{
					then: (fn)->
				}

				"Fake person ##{id}"

			scope = populateScope(routeParamsStub, dataStub)

			expect(scope.person).toBe("Fake person #5");