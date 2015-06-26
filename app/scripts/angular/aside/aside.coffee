module.exports = (angular)->
  'use strict'
  require('./aside-controllers.coffee')(angular)
  require('./aside-directives.coffee')(angular)
  angular.module("App.aside",[
    "App.aside.aside-controllers"
    "App.aside.aside-directives"
  ])