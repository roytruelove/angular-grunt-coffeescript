name = 'common.directives.glowGreenOnMouseoverDirective'
 
# Note that for directives I keep the name SHORT
# and they do not match the name of the module
angular.module(name,[]).directive('glowGreenOnMouseover', [
	'$log'
	($log)->
		(scope, element, attrs) ->

			element.bind 'mouseenter', () ->
				$(element).addClass('greenGlow')

			element.bind 'mouseleave', () ->
				$(element).removeClass('greenGlow')
	])