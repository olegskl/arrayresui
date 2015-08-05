#
# Gulp pipeline notification helpers.
# @module gulp/helpers/notify
#

#
# Pops an error message and ends stream without breaking it.
# @param  {Error}     error Captured error.
# @return {undefined}       Nothing returned.
#
exports.andContinue = (error) ->
  gulpNotify = require 'gulp-notify'

  # Construct a developer-friendly error message:
  message = error.message
  if typeof error.line is 'number'
    message += " at line #{error.line}, column #{error.column}"
  if typeof error.annotated is 'string'
    message += " #{error.annotated}"

  # Send a message to the system notification center:
  gulpNotify.onError(
    title: 'Error'
    message: message
  ) arguments...

  # Gracefully terminate the current stream to prevent
  # running next pipes which might be dependent on it:
  this.emit 'end'

#
# Logs an error message and forces process to exit with error code.
# @param  {Error}     error Captured error.
# @return {undefined}       Nothing returned.
#
exports.andExit = (error) ->
  gulpUtil = require 'gulp-util'

  # Log error to console:
  gulpUtil.log gulpUtil.colors.red error.message

  # Force exit with error code:
  process.exit 1
