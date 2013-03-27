# angular-grunt-coffeescript
# A Seed project for large CoffeeScript AngularJS projects

## Motivation

* I needed a seed project so that I could get a real [AngularJS](http://angularjs.org/) application up and running quickly, with all the fixin's
* I wanted to share some conventions that have worked well for a large CoffeeScript AngularJS project

### But I code in Javascript!

All of the conventions and lessons-learned demonstratred here can be applied to a Javascript-based project.  

## Features

* Pure [CoffeeScript](http://coffeescript.org/)
* Leverages [bootstrap](http://twitter.github.com/bootstrap/index.html)
* [Grunt](http://gruntjs.com)-based build script that:
    * Starts a server and immediately deploys changes as you code
    * Allows for a clean seperation between the organization of your source code and that of your served files
    * A minified and concatenated distribution
* Incorporates most major aspects of AngularJS
    * Modules, directives, views, services, controllers, filters, dependency injection, etc.
* Demonstrates 3rd party library integration using a 'global' library wrapped in a module, in this case [toastr](http://codeseven.github.com/toastr/)).
* Ability to customize the app for each environment (dev, qa, prod, etc.)
* Opinionated conventions for:
    * naming Modules and Angular 'Items'
    * sharing services, directives, filters, etc across views

## Building and Running

### Initial setup

1. Ensure that you have [node](http://nodejs.org/), [npm](https://npmjs.org/), [grunt](http://gruntjs.com/), and [coffeescript](http://coffeescript.org/) installed and in your path
1. Clone this repository
1. Run `npm install` to pull down all build-time dependencies

### Start server and watch for changes

The default grunt task will start the server and watch for changes.  When changes are made the project is rebuilt, pushed to the server, and all unit tests are run through Testacular.

* To run the default grunt task, run `grunt`
* Point the browser to `http://localhost:9876` to connect the Testacular server
* Point another browser window to `http://localhost:8000` to view the app

## Build Output

When you run the default Grunt task, you will see this output in your project's directory.  `target/build/main` is served by the webserver.

    target/build
      main/              # all application files and code
        index.html       # your old friend index.html
        js/
          app.js         # all of your application's code, concatenated
          lib.js         # all 3rd party library code, concatenated
        style/
          app.css        # all of your application's css, concatenated
          lib.css        # all 3rd party library css, concatenated
        ...              # a directory per 'package', with all the static files (html, imgs, etc)
      test/              # all tests

## Conventions

All of these are demonstrated in the example code.

### Directories & Files

    src/             
      main/              # application root
        index.html       # good ol' index.html
        app/             # contains all application files
          app.coffee     # handles routing, module wiring, and bootstrapping
          ...            # a directory per 'package'.  Described later
        lib/             # all 3rd party code
          ...            # a directory per 3rd party lib
      test/              # all test files and code
        config           # testacular configs
        lib              # test-time libraries
        ...              # directory per package, generally with a Spec file per package
      profile/           # environment-specific overrides.  See 'Profiles'
        prod             # overrides for prod env
          ...
        dev              # overrides for dev env, the default
          ...

Related files are grouped together. Best explained by example:

* All files for the app's 'details view' will go into the detailsView directory.  None of the files in this directory will be used outside of this view
* 'Common' code that's shared between views are grouped under the 'common' directory

The structure you use for these groupings is up to you, but I've found that the 'xxxView' and 'common' structure works well.

### Modules and 'Angular Items'

An 'Angular Item' is, for instance, a Vaule, Factory, Directive, Filter, Controller, etc.  There's no good term for these things, unfortunately.

 Because we're using dependency injection, we don't need to use any javascript namespacing.  Everything in CoffeeScript is in an anonymous function and so never global, and everything we need we make sure is available in a module.

The key, then, becomes the naming convention we use for both our modules and the Angular Items.

 - We use one module per Angular Item.  We don't group Items together (I don't see the benefit).
 - Module name matches the name and path of the file in which it's defined.  So the module for the app's common Data service would be `common.services.dataSvc`
 - Item name depends on the type of the item.
     - For *values* and *factories*, which are generally used to provide Controllers, Services, and wrappers around 3rd parties libs, the *name of my Item is the exact same name as the module*.
     - For *directives* and *filters*, we do not namespace.  Because they have to be referenced in the DOM, short names are best for directives and filters.  See the code for examples.

 Having one module per Item makes wiring easy - We just list all of our modules in `app.coffee`.

### Misc Conventions

* Never use a global function for a controller, always a module
* Always use the 'array' format for dependency injection to avoid minification issues

## Profiles

Under `src/profiles` is a directory per 'profile' (currently dev and prod, but add as many as you need).  During the build, these directories are overlayed directly on top of the main code, overriding anything that may be there.  By default the build will use the 'dev' profile.

### envProvider

The `common.services.envProvider` module is where most of the environment-specific aspects of your application will be defined.  At the very least each environment must provide an instance of this module.  The module is responsible for:

* Defining the `common.services.envProvider` provider.  This provider can optionally have an `appConfig` function, which is run in the *config block of the application module*.  Since it is a provider it must have a $get function which defines how to instaniate the `common.services.env` service.
* Defining the `common.services.env` service.  This service will generally store any environment-specific data, and optionally an `appRun` function, which is run in the *run block of the application module*.

If you take a look at the prod module, you'll see that the provider simply instantiates the service, and the service provides the production URL. 

The dev module, however, uses [$httpBackend](http://docs.angularjs.org/api/ngMockE2E.$httpBackend) to act as a fake server.  Since $httpBackend is set up in a run block, we put the setup code in the `appRun` function.

Having the ability to run custom code in the application module's config and run blocks as well as having an injectable service that abstracts away all environment specific aspects of your application gives you the option to set up your application's enviroments in whatever ways you need.

To run an enviroment specific build, add an `profile` flag to your command line as follows:

    grunt --profile prod 

## Everything Else

A distribution build minifies your js and css.  Run `grunt dist`

## Thanks

Some of the ideas here are my own but many are built upon the work of others:

* The folks that contributed to [this thread](https://groups.google.com/forum/#!topic/angular/O_3mlKiW-OQ/discussion)
* James Wanga and his [angular-sprout](https://github.com/thedigitalself/angular-sprout) project
* The [AngularJS Team](https://github.com/angular/angular.js/graphs/contributors)
