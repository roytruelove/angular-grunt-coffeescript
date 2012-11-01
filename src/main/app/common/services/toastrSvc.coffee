###
Example of how to wrap a 3rd party library, allowing it to be injectable instead of using the global var
###
name = 'common.services.toastrWrapperSvc'

angular.module(name, []).factory(name, () ->

	# override some default settings
	# window.toastr.options.timeOut = 1000

	return window.toastr
)