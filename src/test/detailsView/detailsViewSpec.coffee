describe "Details View", () ->

	beforeEach ()->

	describe "Mattizer Filter", () ->

		filter = null

		beforeEach ()->

			# ensure that the mattizer filter is loaded
			module('detailsView.mattizerFilter')

			# populate 'filter' with the mattizer filter, using the angular '$filter' service
			inject (['$filter', ($filter) ->
				filter = $filter('mattizer')
			])

		it "replaces the string 'Matthew' with 'Matt'", () ->
			expect(filter('Matthew')).toBe('Matt');

		it "does not replace other names", () ->
			expect(filter('John')).toBe('John');

	describe "Controller", () ->

		populateScope = (routeParamsStub, dataStub)->

			ctrl = null
			scope = null

			module('detailsView.detailsViewCtrl')

			# populate 'ctrl' with controller
			inject (['$rootScope', '$controller', '$log',
				($rootScope, $controller, $log) ->

					scope = $rootScope.$new

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
				"Fake person ##{id}"

			scope = populateScope(routeParamsStub, dataStub)

			expect(scope.person).toBe("Fake person #5");