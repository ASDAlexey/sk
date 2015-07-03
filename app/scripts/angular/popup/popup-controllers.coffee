module.exports = (angular)->
  'use strict'
  controller = angular.module("App.popup.popup-controllers",[])
  controller.controller "PopupCtrl",[
    "$scope"
    "$rootScope"
    ($scope,$rootScope) ->
      $scope.openPopup = (msg,data) ->
        $rootScope.$broadcast 'popup',
          data : data
          msg : msg
          isOpened : true
      $scope.$on 'cart:changed',(event,response) ->
        $scope.count = _.sum response.data.products,(product) ->
          parseInt(product.quantity)
  ]