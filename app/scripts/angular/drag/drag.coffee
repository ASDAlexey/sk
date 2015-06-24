module.exports = (angular,$)->
  'use strict'
  require('./drag-directives.coffee')(angular)
  require('./drag-controllers.coffee')(angular)
  angular.module("App.drag",[
    "App.drag.drag-controllers"
    "App.drag.drag-directives"
  ])