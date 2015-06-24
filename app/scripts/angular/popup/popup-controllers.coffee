module.exports = (angular)->
  'use strict'
  controller = angular.module("App.popup.popup-controllers",[])
  controller.controller "PopupCtrl",[
    "$scope"
    ($scope) ->
  #    $scope.isSearchStart=false
  ]