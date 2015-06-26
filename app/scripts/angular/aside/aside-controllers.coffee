module.exports = (angular)->
  'use strict'
  controller = angular.module("App.aside.aside-controllers",[])
  controller.controller "AsideCtrl",[
    "$scope"
    ($scope) ->
      $scope.switchers = {}
      $scope.switch = (name)->
        $scope.switchers[name].isOpen = !$scope.switchers[name].isOpen
  ]