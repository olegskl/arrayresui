Build system
================================================================================

This is the build system for ArrayResUi.

 - Run `gulp` or `gulp serve-dev` to launch a live-reloaded site from dev build.
 - Run `gulp serve-dist` to launch a live-reloaded site from distribution build.
 - Run `gulp dist` to build a distribution version.

By default both *dev* and *dist* will write the generated code to the *./build*
folder. Use `--dest` option to modify this behavior. Useful when deploying to
the production environment, e.g. `gulp dist --dest="/srv/arrayresui"`.

    'use strict'


Dependencies
--------------------------------------------------------------------------------

    argv = (require 'minimist') process.argv[2..]

    browserify = require 'browserify'
    coffeeReactify = require 'coffee-reactify'
    sourceStream = require 'vinyl-source-stream'
    buffer = require 'vinyl-buffer'
    gutil = require 'gulp-util'

    gulp = require 'gulp'
    merge = require 'gulp-merge'
    sequence = require 'run-sequence'
    del = require 'del'
    coffee = require 'gulp-coffee'
    inject = require 'gulp-inject'
    concat = require 'gulp-concat'
    stylus = require 'gulp-stylus'
    autoprefixer = require 'gulp-autoprefixer'
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
    source.clientScriptMain = "#{source.client}/scripts/main.coffee"
    source.clientStyles = "#{source.client}/styles/main.*"

    source.server = 'src/server'
    source.serverScripts = "#{source.server}/**/*.*coffee"
    source.serverData = [
      "#{source.server}/**/*.json"
      "#{source.server}/**/*.csv"
    ]


Destination files and folders
--------------------------------------------------------------------------------

    destination = {}

    destination.build = argv.dest or 'build'
    destination.server = "#{destination.build}/server"
    destination.client = "#{destination.server}/static"
    destination.clientScripts = "#{destination.client}/scripts"
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


Running server script task
--------------------------------------------------------------------------------

    gulp.task 'server-running', ->

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

      bundler = browserify
        entries: source.clientScriptMain
        extensions: ['.coffee', '.cjsx']
        transform: [coffeeReactify]

      scripts = bundler
        .bundle()
        .pipe sourceStream 'app.js'
        .pipe do buffer
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
        .pipe inject scripts, transform: transform.scripts
        .pipe do minifyHTML
        .pipe gulp.dest destination.client


Clean distribution build task
--------------------------------------------------------------------------------

    gulp.task 'dist', (cb) ->
      sequence 'clean', ['package', 'server'], 'build-dist', cb


Development build task
--------------------------------------------------------------------------------
Not supposed to be used directly. Use `gulp dev` instead.

    gulp.task 'build-dev', ['favicon'], ->

      bundler = browserify
        entries: source.clientScriptMain
        extensions: ['.coffee', '.cjsx']
        transform: [coffeeReactify]

      scripts = bundler
        .bundle()
        .pipe sourceStream 'app.js'
        .pipe do buffer
        .on 'error', gutil.log
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
      sequence 'clean', ['package', 'server-running'], 'build-dev', cb


Watch task for development build
--------------------------------------------------------------------------------

    gulp.task 'watch-dev', ['browser-sync'], ->
      gulp
        .watch 'src/**/*', ['dev']


Watch task for distribution build
--------------------------------------------------------------------------------

    # gulp.task 'watch-dist', ->
    #   gulp
    #     .watch 'src/**/*', ['dist']


Serve task for development build
--------------------------------------------------------------------------------

    gulp.task 'serve-dev', (cb) ->
      sequence 'dev', 'watch-dev', cb


Serve task for distribution build
--------------------------------------------------------------------------------
Do not use for production. This is just to check if the app compiles.

    gulp.task 'serve-dist', (cb) ->
      sequence 'dist', cb


Default task
--------------------------------------------------------------------------------
This task is your best friend. Run `gulp` to start the development environment.

    gulp.task 'default', ['serve-dev']
