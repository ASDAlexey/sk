module.exports = (angular)->
  'use strict'
  require('./news-controllers.coffee')(angular)
  require('./popup-directives.coffee')(angular)
  angular.module("App.news",[
    "App.news.news-controllers"
    "App.news.news-directive"
  ])