module.exports = (angular)->
  'use strict'
  controller = angular.module("App.popup.popup-controllers",[])
  controller.controller "PopupCtrl",[
    "$scope"
    "$rootScope"
    ($scope,$rootScope) ->
      $scope.openPopup = (msg,data) ->
        console.log('sss')
        $rootScope.$broadcast 'popup',
          data : data
          msg : msg
          isOpened : true
      $scope.closePopup = (msg,data) ->
        $rootScope.$broadcast 'popup',
          data : data
          msg : msg
          isOpened : false
  ]