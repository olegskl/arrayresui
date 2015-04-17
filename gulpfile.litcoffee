Build system
================================================================================

This is the build system for tbd.

 - Run `gulp` or `gulp serve-dev` to launch a live-reloaded site from dev build.
 - Run `gulp serve-dist` to launch a live-reloaded site from distribution build.
 - Run `gulp dist` to build a distribution version.

By default both *dev* and *dist* will write the generated code to the *./build*
folder. Use `--dest` option to modify this behavior. Useful when deploying to
the production environment, e.g. `gulp dist --dest="/srv/tbd"`.

    'use strict'


Dependencies
--------------------------------------------------------------------------------

    argv = (require 'minimist') process.argv[2..]

    gulp = require 'gulp'
    merge = require 'gulp-merge'
    sequence = require 'run-sequence'
    del = require 'del'
    coffee = require 'gulp-coffee'
    inject = require 'gulp-inject'
    concat = require 'gulp-concat'
    stylus = require 'gulp-stylus'
    autoprefixer = require 'gulp-autoprefixer'
    ngAnnotate = require 'gulp-ng-annotate'
    templateCache = require 'gulp-angular-templatecache'
    minifyJS = require 'gulp-uglify'
    minifyCSS = require 'gulp-minify-css'
    minifyHTML = require 'gulp-minify-html'

    server = require 'gulp-develop-server'
    browserSync = require 'browser-sync'


Source files and folders
--------------------------------------------------------------------------------

    source = {}

    source.package = 'package.json'

    source.client = 'src/client'
    source.clientIndex = "#{source.client}/index.html"
    source.clientFavicon = "#{source.client}/favicon.ico"
    source.clientScripts = "#{source.client}/scripts/**/*.*coffee"
    source.clientTemplates = "#{source.client}/templates/**/*.tpl.html"
    source.clientStyles = "#{source.client}/styles/main.*"

    source.server = 'src/server'
    source.serverScripts = "#{source.server}/**/*.*coffee"
    source.serverData = "#{source.server}/**/*.json"


Destination files and folders
--------------------------------------------------------------------------------

    destination = {}

    destination.build = argv.dest or 'build'
    destination.server = "#{destination.build}/server"
    destination.client = "#{destination.server}/static"
    destination.clientScripts = "#{destination.client}/scripts"
    destination.clientTemplates = "#{destination.client}/templates"
    destination.clientStyles = "#{destination.client}/styles"


Server options
--------------------------------------------------------------------------------

    serverOptions =
      path: "#{destination.server}/server.js"
      env:
        PORT: 1337
        CACHE_AGE: 0

Existing vhost
--------------------------------------------------------------------------------

    vhost = "http://localhost:#{serverOptions.env.PORT}"


Transforms for `gulp-inject`
--------------------------------------------------------------------------------

    transform =
      scripts: (filePath, file) ->
        "<script>#{file.contents.toString 'utf8'}</script>"
      styles: (filePath, file) ->
        "<style>#{file.contents.toString 'utf8'}</style>"


Clean task
--------------------------------------------------------------------------------

    gulp.task 'clean', (cb) ->
      del destination.build, force: true, cb


Favicon task
--------------------------------------------------------------------------------

    gulp.task 'favicon', ->
      gulp
        .src source.clientFavicon
        .pipe gulp.dest destination.client


Package task
--------------------------------------------------------------------------------

    gulp.task 'package', ->
      gulp
        .src source.package
        .pipe gulp.dest destination.build


Browser-sync task
--------------------------------------------------------------------------------

    gulp.task 'browser-sync', ->
      browserSync
        proxy: vhost
        open: true


Server script task
--------------------------------------------------------------------------------

    gulp.task 'server', ->

      gulp
        .src source.serverData
        .pipe gulp.dest destination.server

      gulp
        .src source.serverScripts
        .pipe coffee bare: true # decoffeify without IIFE wrappers
        .pipe gulp.dest destination.server # write to disk
        .pipe server serverOptions # restart the server


Distribution build task
--------------------------------------------------------------------------------
Not supposed to be used directly. Use `gulp dist` instead.

    gulp.task 'build-dist', ['favicon'], ->

      templates = gulp
        .src source.clientTemplates
        .pipe templateCache
          root: 'templates'
          module: 'ArrayResUi'

      scripts = gulp
        .src source.clientScripts
        .pipe coffee bare: false # decoffeify with IIFE wrappers

      scriptsAndTemplates = merge scripts
        .add templates
        .pipe do ngAnnotate
        .pipe concat 'all.js'
        .pipe do minifyJS

      styles = gulp
        .src source.clientStyles
        .pipe do stylus
        .pipe concat 'all.css'
        .pipe autoprefixer
          browsers: ['last 2 versions']
          cascade: false
        .pipe do minifyCSS

      gulp
        .src source.clientIndex
        .pipe inject styles, transform: transform.styles
        .pipe inject scriptsAndTemplates, transform: transform.scripts
        .pipe do minifyHTML
        .pipe gulp.dest destination.client
        .pipe browserSync.reload stream: true


Clean distribution build task
--------------------------------------------------------------------------------

    gulp.task 'dist', (cb) ->
      sequence 'clean', ['package', 'server'], 'build-dist', cb


Development build task
--------------------------------------------------------------------------------
Not supposed to be used directly. Use `gulp dev` instead.

    gulp.task 'build-dev', ['favicon'], ->

      gulp
        .src source.clientTemplates
        .pipe gulp.dest destination.clientTemplates

      scripts = gulp
        .src source.clientScripts
        .pipe coffee bare: false # decoffeify with IIFE wrappers
        .pipe gulp.dest destination.clientScripts

      styles = gulp
        .src source.clientStyles
        .pipe do stylus
        .pipe autoprefixer
          browsers: ['last 2 versions']
          cascade: false
        .pipe gulp.dest destination.clientStyles

      gulp
        .src source.clientIndex
        .pipe inject styles, ignorePath: destination.client
        .pipe inject scripts, ignorePath: destination.client
        .pipe gulp.dest destination.client
        .pipe browserSync.reload stream: true


Clean development build task
--------------------------------------------------------------------------------

    gulp.task 'dev', (cb) ->
      sequence 'clean', ['package', 'server'], 'build-dev', cb


Watch task for development build
--------------------------------------------------------------------------------

    gulp.task 'watch-dev', ['browser-sync'], ->
      gulp
        .watch 'src/**/*', ['dev']


Watch task for distribution build
--------------------------------------------------------------------------------

    gulp.task 'watch-dist', ['browser-sync'], ->
      gulp
        .watch 'src/**/*', ['dist']


Serve task for development build
--------------------------------------------------------------------------------

    gulp.task 'serve-dev', (cb) ->
      sequence 'dev', 'watch-dev', cb


Serve task for distribution build
--------------------------------------------------------------------------------
Do not use for production. This is just to check if the app compiles.

    gulp.task 'serve-dist', (cb) ->
      sequence 'dist', 'watch-dist', cb


Default task
--------------------------------------------------------------------------------
This task is your best friend. Run `gulp` to start the development environment.

    gulp.task 'default', ['serve-dev']
