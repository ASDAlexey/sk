module.exports = (angular)->
  'use strict'
  controller = angular.module("App.tabs.tabs-controllers",[])
  controller.controller "TabCtrl",[
    "$scope"
    ($scope) ->
      $scope.currentTab = 0
      $scope.side = 'left'
      $scope.switchTab = (number)->
        if $scope.currentTab > number
          $scope.side = 'left'
        else
          $scope.side = 'right'
        $scope.currentTab = number
  ]
  controller.controller "ContactsCrl",[
    "$scope"
    "$rootScope"
    ($scope,$rootScope) ->
      $rootScope.currentTab = 0
      $scope.switchTab = (number)->
        $rootScope.currentTab=number
  ]