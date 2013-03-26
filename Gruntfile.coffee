module.exports = (grunt)->

   ###############################################################
   # Constants
   ###############################################################

   PROFILE = grunt.option('profile') || 'dev'

   SRC_DIR =                    'src'
   SRC_TEST_DIR =               "#{SRC_DIR}/test"
   SRC_PROFILES_DIR =           "#{SRC_DIR}/profiles"
   CURRENT_PROFILE_DIR =        "#{SRC_PROFILES_DIR}/#{PROFILE}"

   TARGET_DIR =                 'target'
   BUILD_DIR =                  "#{TARGET_DIR}/build"
   BUILD_MAIN_DIR =             "#{BUILD_DIR}/main"

   STAGE_DIR =                  "#{TARGET_DIR}/stage"
   STAGE_APP_DIR =              "#{STAGE_DIR}/app"
   STAGE_TEST_DIR =             "#{STAGE_DIR}/test"

   BUILD_TEST_DIR =             "#{BUILD_DIR}/test" 

   # index.html is special, since it should be moved out of the index view and into the root
   SRC_INDEX_HTML =             "#{STAGE_APP_DIR}/index/index.html"
   DEST_INDEX_HTML =            "#{BUILD_MAIN_DIR}/index.html"

   ###############################################################
   # Config
   ###############################################################

   grunt.initConfig

      clean:
         main:
            src: TARGET_DIR 

      copy:

         # Copy all non-profile to the stage dir.  Stage dir allows us to override
         # non-profile-specific code w/ the profile defined on the cmd line (or 'dev' by default)
         stage:
            files: [
               {
                  expand:        true
                  cwd:           "#{SRC_DIR}/main"
                  src:           '**'
                  dest:          STAGE_DIR
               }
            ]

         # override staging dir w/ profile-specific files
         profiles:
            files: [
               {
                  expand:        true
                  cwd:           CURRENT_PROFILE_DIR  
                  src:           '**'
                  dest:          STAGE_DIR
               }
            ]

         # copies all files from staging to the build dir that do not need any further processing
         static:
            files: [
               {
                  src:           SRC_INDEX_HTML
                  dest:          DEST_INDEX_HTML
               }
               {
                  expand:        true
                  cwd:           STAGE_APP_DIR
                  src:           ['**/*.{html,jpg,png,gif}', "!{SRC_INDEX_HTML}"]
                  dest:          BUILD_MAIN_DIR
               }
            ]

         test:
            files: [
               {
                  expand:        true
                  cwd:           SRC_TEST_DIR
                  src:           ['{lib,config}/**']
                  dest:          BUILD_TEST_DIR
               }
            ]

      concat:
         app_css:
            src: "#{STAGE_APP_DIR}/**/*.css"
            dest: "#{BUILD_MAIN_DIR}/style/app.css"
         lib_css: 
            src: "#{STAGE_DIR}/lib/**/*.css"
            dest: "#{BUILD_MAIN_DIR}/style/lib.css"
         lib_js: 
            src: "#{STAGE_DIR}/lib/**/*.js"
            dest: "#{BUILD_MAIN_DIR}/js/lib.js"

      coffee:
         app:
            src: "#{STAGE_APP_DIR}/**/*.coffee"
            dest: "#{BUILD_MAIN_DIR}/js/app.js"
         test:
            src: "#{SRC_TEST_DIR}/**/*.coffee"
            dest: "#{BUILD_TEST_DIR}/js/lib.js"

      uglify:
         lib_js:
            src: "#{BUILD_MAIN_DIR}/js/lib.js"
            dest: "#{BUILD_MAIN_DIR}/js/lib.js"
         app_js:
            src: "#{BUILD_MAIN_DIR}/js/app.js"
            dest: "#{BUILD_MAIN_DIR}/js/app.js"

      cssmin:
         lib_css:
            src: "#{BUILD_MAIN_DIR}/style/lib.css"
            dest: "#{BUILD_MAIN_DIR}/style/lib.css"
         app_css:
            src: "#{BUILD_MAIN_DIR}/style/app.css"
            dest: "#{BUILD_MAIN_DIR}/style/app.css"

      connect:
         server:
            options:
               base: BUILD_MAIN_DIR

      regarde:
         build:
            options:
               base: BUILD_MAIN_DIR
            files: ["#{SRC_DIR}/**/*.{css,coffee,js,html}"]
            tasks: ['build']
         # Note, disabling this until https://github.com/mklabs/tiny-lr/issues/8 is resolved
         # livereload:
         #   files: ["#{BUILD_DIR}/**/*.{css,js,html}"]
         #   tasks: ['livereload']


   ##############################################################
   # Dependencies
   ###############################################################
   grunt.loadNpmTasks('grunt-contrib-coffee')
   grunt.loadNpmTasks('grunt-contrib-copy')
   grunt.loadNpmTasks('grunt-contrib-clean')
   grunt.loadNpmTasks('grunt-contrib-concat')
   grunt.loadNpmTasks('grunt-contrib-uglify')
   grunt.loadNpmTasks('grunt-contrib-cssmin')
   grunt.loadNpmTasks('grunt-contrib-connect')
   grunt.loadNpmTasks('grunt-contrib-livereload')
   grunt.loadNpmTasks('grunt-regarde')

   ###############################################################
   # Alias tasks
   ###############################################################

   grunt.registerTask('build', ['copy','concat','coffee'])
   grunt.registerTask('watcher', ['livereload-start', 'connect', 'regarde']) 
   grunt.registerTask('dist', ['build','uglify','cssmin'])

   grunt.registerTask('default', ['clean','build','watcher'])



