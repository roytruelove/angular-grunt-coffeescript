describe "Details View", () ->

	beforeEach ()->

	describe "Mattizer Filter", () ->

		filter = null

		beforeEach ()->
			
			module('detailsView.mattizerFilter')
			inject (['$filter', ($filter) ->
				filter = $filter('mattizer')
			])

		it "replaces the string 'Matthew' with 'Matt'", () ->
			expect(filter('Matthew')).toBe('Matt');