module.exports = (angular)->
  'use strict'
  controller = angular.module("App.aside.aside-controllers",[])
  controller.controller "AsideCtrl",[
    "$scope"
    "$timeout"
    ($scope,$timeout) ->
      $scope.switchers = {}
      $scope.switch = (name)->
        $scope.switchers[name].isOpen = !$scope.switchers[name].isOpen
      $scope.reset = (obj)->
        switchers = angular.copy($scope.switchers)
        angular.forEach switchers,(el,key)->
          if _.isObject(el) and key isnt 'price'
            angular.forEach el,(e,k)->
              if _.isBoolean(e)
                switchers[key][k] = false
        $scope.switchers=switchers
      $scope.options =
        smooth : true
        realtime : true
        dimension : " руб."
        css :
          background : {"background-color" : "#dedede"},
          default : {"background-color" : "none"},
          pointer : {"background-color" : "#060606"}
  ]