module.exports = (angular)->
  'use strict'
  controller = angular.module("App.slider.slider-controllers",[])
  controller.controller "groupSliderCtrl",[
    "$scope"
    "$rootScope"
    ($scope,$rootScope) ->
      $scope.currentGroup = 0
      $scope.setCountGroups = (count)->
        $scope.count = count
      $scope.next = ()->
        if $scope.currentGroup < $scope.count - 1
          $scope.currentGroup++
          $rootScope.$broadcast('switchGroup',
            numberCurrentGroup : $scope.currentGroup
            to : 'next'
          )
      $scope.prev = ()->
        if $scope.currentGroup > 0
          $scope.currentGroup--
          $rootScope.$broadcast('switchGroup',
            numberCurrentGroup : $scope.currentGroup
            to : 'prev'
          )
  ]