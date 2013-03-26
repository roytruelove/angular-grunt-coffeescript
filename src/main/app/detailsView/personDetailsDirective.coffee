name = 'detailsView.personDetailsDirective'
 
# Note that for directives I keep the name SHORT
# and they do not match the name of the module
angular.module(name,[]).directive('personDetails', [
	'$log'
	($log)->
		templateUrl: 'detailsView/personDetailsDirectiveTemplate.html'
		scope: 
			who: '=personDetails'
		compile: (tElement, tAttrs, transclude) ->
			# note, no compile step, here for demonstration only
			linkFn = (scope, lElement, attrs) ->
				# Doesn't actually do anything except load the template..

	])
