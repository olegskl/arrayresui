Build system
================================================================================

This is the build system for ArrayResUi.

- Run `gulp` or `gulp dev:serve` to launch a live-reloaded site from dev build.
- Run `gulp dev:build` to build a development version.
- Run `gulp dist:build` to build a distribution version.

By default both *dev* and *dist* will write the generated code to the *./build*
folder. Use `--dest` option to modify this behavior. Useful when deploying to
the production environment, e.g. `gulp dist --dest="/srv/arrayresui"`.


    require('gulp')

      .task 'default', ['dev:serve']

      .task 'shared:clean-build', require './gulp/tasks/shared/clean-build'
      .task 'shared:favicon', require './gulp/tasks/shared/favicon'

      .task 'dev:build', require './gulp/tasks/dev/build'
      .task 'dev:serve', require './gulp/tasks/dev/serve'
      .task 'dev:browser-sync-create', require './gulp/tasks/dev/browser-sync-create'
      .task 'dev:browser-sync-init', require './gulp/tasks/dev/browser-sync-init'
      .task 'dev:watch-index', require './gulp/tasks/dev/watch-index'
      .task 'dev:watch-core-styles', require './gulp/tasks/dev/watch-core-styles'
      .task 'dev:watch-server', require './gulp/tasks/dev/watch-server'
      .task 'dev:core-styles', require './gulp/tasks/dev/core-styles'
      .task 'dev:core-scripts', require './gulp/tasks/dev/core-scripts'
      .task 'dev:vendor-scripts', require './gulp/tasks/dev/vendor-scripts'
      .task 'dev:index-file', require './gulp/tasks/dev/index-file'
      .task 'dev:http-server', require './gulp/tasks/dev/http-server'

      .task 'dist:build', require './gulp/tasks/dist/build'
      .task 'dist:core-scripts', require './gulp/tasks/dist/core-scripts'
      .task 'dist:core-styles', require './gulp/tasks/dist/core-styles'
      .task 'dist:http-server', require './gulp/tasks/dist/http-server'
      .task 'dist:index-file', require './gulp/tasks/dist/index-file'
      .task 'dist:package-file', require './gulp/tasks/dist/package-file'
      .task 'dist:vendor-scripts', require './gulp/tasks/dist/vendor-scripts'
