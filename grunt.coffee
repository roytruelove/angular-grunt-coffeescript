module.exports = (grunt)->

   ###############################################################
   # Constants
   ###############################################################

   ENV = grunt.option('env') || 'dev'

   # # Application src
   # SRC_ROOT= 'src/main/'
   # SRC_APP_ROOT= "#{SRC_ROOT}/app/"

   # SRC_INDEX = "#{SRC_ROOT}/index.html"
   # SRC_HTML = "#{SRC_APP_ROOT}/**/*.html"
   # SRC_CSS = "#{SRC_APP_ROOT}/**/*.css"
   # SRC_IMG = "#{SRC_APP_ROOT}/**/*.jpg" # TODO jpgs are not the only images..
   # SRC_COFFEE= "#{SRC_APP_ROOT}/**/*.coffee"

   # # 3rd party libraries
   # SRC_LIB_ROOT = "#{SRC_ROOT}/lib/"
   # SRC_LIB_CSS = "#{SRC_LIB_ROOT}/**/*.css"
   # SRC_LIB_JS = "#{SRC_LIB_ROOT}/**/*.js"
   # TEST_COFFEE = "TODO"

   ###############################################################
   # Config
   ###############################################################

   grunt.initConfig

      clean:
         main: 'target'

      copy:

         # Copy all non-env to the stage dir.  Stage dir allows us to override
         # non-env-specific code w/ the env defined on the cmd line (or 'dev' by default)
         stage:
            options:
               basePath: 'src/main'
            files:
               'target/stage/': 'src/main/**'

         # override staging dir w/ env-specific files
         env:
            options:
               basePath: "src/env/#{ENV}/"
            files:
               'target/stage/': "src/env/#{ENV}/**"

         # copies all files to the build dir that do not need any further processing
         static:
            options:
               basePath: 'target/stage/app/'
            files:

               # index file is handled specially
               'target/build/main/index.html':
                  'target/stage/app/index/index.html'

               'target/build/main/': [
                  '!target/stage/app/index/index.html' # will only work after grunt 0.4 release
                  'target/stage/app/**/*.html'
                  'target/stage/app/**/*.jpg'
                  'target/stage/app/**/*.png'
                  'target/stage/app/**/*.gif' # add extentions as needed
               ]

         # copy test libs and configs
         test:
            options:
               basePath: 'src/test'
            files:
               'target/build/test/': [
                  'src/test/lib/**'
                  'src/test/config/**'
               ]

      testacularServer:
         unit:
            configFile: 'target/build/test/config/unitTests.js'

      testacularRun:
         unit:
            configFile: 'target/build/test/config/unitTests.js'

      concat:
         lib_css: 
            src: 'target/stage/lib/**/*.css'
            dest: 'target/build/main/style/lib.css'
         lib_js: 
            src: 'target/stage/lib/**/*.js'
            dest: "target/build/main/js/lib.js"
         app_css:
            src: 'target/stage/app/**/*.css'
            dest: "target/build/main/style/app.css"

      min:
         lib_js:
            src: "target/build/main/js/lib.js"
            dest: "target/build/main/js/lib.js"
         app_js:
            src: "target/build/main/js/app.js"
            dest: "target/build/main/js/app.js"

      cssmin:
         lib_cssk:
            src: "target/build/main/style/lib.css"
            dest: "target/build/main/style/lib.css"
         app_css:
            src: "target/build/main/style/app.css"
            dest: "target/build/main/style/app.css"

      coffee:
         app:
            files:
               'target/build/main/js/app.js': 'target/stage/app/**/*.coffee'
         test:
            files:
               'target/build/test/js/specs.js': 'src/test/**/*.coffee'

      server:
         base: 'target/build/main'

      # Currently runs the entire build.  If this gets too big, look at breaking
      # it apart by files
      watch:
         buildAndTest: 
            files: 'src/**/*.*'
            tasks: 'build testacularRun:unit'


   ##############################################################
   # Dependencies
   ###############################################################
   grunt.loadNpmTasks('grunt-contrib-coffee')
   grunt.loadNpmTasks('grunt-contrib-copy')
   grunt.loadNpmTasks('grunt-contrib-clean')
   grunt.loadNpmTasks('grunt-css')
   grunt.loadNpmTasks('grunt-testacular')

   ###############################################################
   # Alias tasks
   ###############################################################

   grunt.registerTask('build', 'copy concat coffee')
   grunt.registerTask('watcher', 'server testacularServer:unit watch')
   grunt.registerTask('dist', 'build min cssmin')

   grunt.registerTask('default', 'clean build watcher')