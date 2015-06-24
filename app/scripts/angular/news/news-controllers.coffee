module.exports = (angular)->
  'use strict'
  controller = angular.module("App.news.news-controllers",[])
  controller.controller "NewsCtrl",[
    "$scope"
    "$http"
    "$rootScope"
    ($scope,$http,$rootScope) ->
      @get = (url,$event)->
        history.pushState(null,null,url)
        $rootScope.$broadcast('switchActiveNews',
          event : $event
        )
        $http(
          url : "http://localhost:3000/json/add_news.json"
          method : "GET"
        ).then((response)->
          $rootScope.$broadcast('addNews',
            content : response.data.content
          )
        )
  ]