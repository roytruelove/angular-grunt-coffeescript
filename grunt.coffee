module.exports = (grunt)->

   ###############################################################
   # Constants
   ###############################################################

   PROFILE = grunt.option('profile') || 'dev'

   ###############################################################
   # Config
   ###############################################################

   grunt.initConfig

      clean:
         main: 'target'

      copy:

         # Copy all non-profile to the stage dir.  Stage dir allows us to override
         # non-profile-specific code w/ the profile defined on the cmd line (or 'dev' by default)
         stage:
            options:
               basePath: 'src/main'
            files:
               'target/stage/': 'src/main/**'

         # override staging dir w/ profile-specific files
         profiles:
            options:
               basePath: "src/profiles/#{PROFILE}/"
            files:
               'target/stage/': "src/profiles/#{PROFILE}/**"

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