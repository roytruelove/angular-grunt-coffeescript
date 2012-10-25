module.exports = (grunt)->

   ###############################################################
   # Constants
   ###############################################################

   # Application src
   SRC_ROOT= 'src/main/'
   SRC_APP_ROOT= "#{SRC_ROOT}/app/"

   SRC_INDEX = "#{SRC_ROOT}/index.html"
   SRC_HTML = "#{SRC_APP_ROOT}/**/*.html"
   SRC_CSS = "#{SRC_APP_ROOT}/**/*.css"
   SRC_IMG = "#{SRC_APP_ROOT}/**/*.jpg" # TODO jpgs are not the only images..
   SRC_COFFEE= "#{SRC_APP_ROOT}/**/*.coffee"

   # 3rd party libraries
   SRC_LIB_ROOT = "#{SRC_ROOT}/lib/"
   SRC_LIB_CSS = "#{SRC_LIB_ROOT}/**/*.css"
   SRC_LIB_JS = "#{SRC_LIB_ROOT}/**/*.js"

   ###############################################################
   # Config
   ###############################################################

   grunt.initConfig

      clean:
         main: 'target'

      copy:
         # HTML and Image directories are preserved
         app_static:
            options:
               basePath: SRC_APP_ROOT
            files:
               "target/main/index.html": SRC_INDEX
               "target/main/": [SRC_HTML, SRC_IMG]
      concat:
         lib_css: 
            src: SRC_LIB_CSS
            dest: "target/main/style/lib.css"
         lib_js: 
            src: SRC_LIB_JS
            dest: "target/main/js/lib.js"
         app_css:
            src: SRC_CSS
            dest: "target/main/style/app.css"

      min:
         lib_js:
            src: "target/main/js/lib.js"
            dest: "target/main/js/lib.js"
         app_js:
            src: "target/main/js/app.js"
            dest: "target/main/js/app.js"

      cssmin:
         lib_cssk:
            src: "target/main/style/lib.css"
            dest: "target/main/style/lib.css"
         app_css:
            src: "target/main/style/app.css"
            dest: "target/main/style/app.css"


      coffee:
         app:
            files:
               'target/main/js/app.js': SRC_COFFEE

      server:
         base: 'target/main'

      # Note that we don't watch libraries.  Restart the watcher for that
      watch:
         coffee:
            files: SRC_COFFEE
            tasks: 'coffee:app'

         copy_static:
            files: [SRC_HTML, SRC_INDEX, SRC_IMG]
            tasks: 'copy:app_static'

         concat_css:
            files: [SRC_CSS]
            tasks: ['concat:app_css']

   ##############################################################
   # Dependencies
   ###############################################################
   grunt.loadNpmTasks('grunt-contrib-coffee')
   grunt.loadNpmTasks('grunt-contrib-copy')
   grunt.loadNpmTasks('grunt-contrib-clean')
   grunt.loadNpmTasks('grunt-css')

   ###############################################################
   # Alias tasks
   ###############################################################

   grunt.registerTask('build', 'copy concat coffee')
   grunt.registerTask('dist', 'build min cssmin')
   grunt.registerTask('default', 'clean build server watch')