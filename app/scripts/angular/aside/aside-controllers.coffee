module.exports = (angular)->
  'use strict'
  controller = angular.module("App.aside.aside-controllers",[])
  controller.controller "AsideCtrl",[
    "$scope"
    ($scope) ->
      $scope.switchers = {}
      $scope.switch = (name)->
        $scope.switchers[name].isOpen = !$scope.switchers[name].isOpen
      $scope.options =
        smooth : true
        realtime : true
        dimension : " руб."
        css :
          background : {"background-color" : "#dedede"},
          default : {"background-color" : "none"},
          pointer : {"background-color" : "#060606"}
  ]