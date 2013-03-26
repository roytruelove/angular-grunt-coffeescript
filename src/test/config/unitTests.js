basePath = '../../../../target/build';

files = [
  JASMINE,
  JASMINE_ADAPTER,
  'test/lib/angular/angular.min.js',
  'test/lib/**/*.js',
  'main/js/*.js',
  'test/js/*.js',
];

/* Since we're going to watch using grunt.. */
autoWatch = false;