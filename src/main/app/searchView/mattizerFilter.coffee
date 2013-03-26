# Example of a 'local' filter, applicable only to a certain view
# Converts Matthew to Matt
name = 'searchView.mattizerFilter'

# Note that for filters I keep the name SHORT
# and they do not match the name of the module
angular.module(name, []).filter('mattizer', [
	'$log'
	($log) ->
		(str) ->
			return str.replace("Matthew","Matt");
	])