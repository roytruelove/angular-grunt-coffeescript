###
Should be overwritten by the env specific versin
###
providerName = 'common.services.env' # angular adds the 'Provider' suffix for us.
modName = "#{providerName}Provider"

angular.module(modName, []).provider(providerName, ()->
	throw "Expecting this module to be overridden by an env specific version"
)