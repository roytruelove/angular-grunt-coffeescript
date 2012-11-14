###
Example of a service shared across views.
Wrapper around the data layer for the app.  Hardcoded for testing purposes.
###
providerName = 'common.services.env' # angular adds the 'Provider' suffix for us.
modName = "#{providerName}Provider"

class envProvider

	$get: ()->
		'gotEnv'

angular.module(modName, []).provider(providerName, new envProvider())
