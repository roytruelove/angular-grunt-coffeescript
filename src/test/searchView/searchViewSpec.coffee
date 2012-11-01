describe "Search View", () ->

	describe "Mattizer Filter", () ->

		filter = null

		beforeEach ()->

			# ensure that the mattizer filter is loaded
			module('searchView.mattizerFilter')

			# populate 'filter' with the mattizer filter, using the angular '$filter' service
			inject (['$filter', ($filter) ->
				filter = $filter('mattizer')
			])

		it "replaces the string 'Matthew' with 'Matt'", () ->
			expect(filter('Matthew')).toBe('Matt');

		it "does not replace other names", () ->
			expect(filter('John')).toBe('John');
