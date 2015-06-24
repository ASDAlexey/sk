module.exports = (angular)->
  'use strict'
  controller = angular.module("App.drag.drag-controllers",[])
  controller.controller "ScrollerCtrl",[
    "$scope"
    "$rootScope"
    ($scope,$rootScope) ->
      $rootScope.currentSlide = 0
      $scope.toSlide = (number,$event)->
        $rootScope.currentSlide = number
        $rootScope.$broadcast('toSlide',
          number : number
          event : $event
        )
      $scope.prev = ($event)->
        $rootScope.$broadcast('toSlideSwitch',
          event : $event
          side : "prev"
        )
      $scope.next = ($event)->
        $rootScope.$broadcast('toSlideSwitch',
          event : $event
          side : "next"
        )
  ]