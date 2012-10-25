###
Simple wrapper around jqueryUI's tooltip
###
name = 'common.directives.uiTooltipDirective'
 
# Note that for directives I keep the name SHORT
# and they do not match the name of the module
angular.module(name,[]).directive('uiTooltip', [
	'$log'
	($log)->
		(scope, element, attrs) ->
			$(element).tooltip()
	])