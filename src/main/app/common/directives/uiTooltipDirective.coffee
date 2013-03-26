###
Simple wrapper around bootstrap's tooltip
###
name = 'common.directives.uiTooltipDirective'
 
# Note that for directives the directive name is SHORT
# and does not match the name of the module
angular.module(name,[]).directive('uiTooltip', [
	'$log'
	($log)->
		(scope, element, attrs) ->
			$(element).tooltip()
	])