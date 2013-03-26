###
Takes a string and makes it lowercase
Example of a 'common' filter that can be shared by all views
###
name = 'common.filters.toLowerFilter'

# Note that for filters I keep the name SHORT
# and they do not match the name of the module
angular.module(name, []).filter('toLower', [
	'$log'
	($log) ->
		(str) ->
			return str.toLowerCase()
	])