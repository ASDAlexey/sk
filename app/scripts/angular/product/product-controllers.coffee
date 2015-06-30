module.exports = (angular)->
  'use strict'
  controller = angular.module("App.product.product-controllers",[])
  controller.controller "ProductCtrl",[
    "$scope"
    "Product"
    ($scope,Product) ->
      $scope.product = {}
      $scope.switchClass = (number)->
        $scope.product.virtuemart_product_id = number
        $scope.product.task = "product"
        new Product($scope.product).$update().then((data)->
          $scope.product=data
        )
  ]
  controller.controller "VoteCtrl",[
    "$scope"
    "$cookieStore"
    "Product"
    ($scope,$cookieStore,Product) ->
      $scope.currentVote = 0
      $scope.isActive=false
      $scope.setVote = (number)->
        $scope.currentVote=number
        $scope.isActive=true
        $scope.product.currentVote=number
      $scope.sendVote=(product)->
        arrIsVoted=[]
        if $cookieStore.get('vote')
          arrIsVoted=angular.fromJson($cookieStore.get('vote'))
        if _.indexOf(arrIsVoted,$scope.product.id) == -1
          arrIsVoted.push $scope.product.id
          $cookieStore.put('vote',angular.toJson(arrIsVoted))
          $scope.product.vote_counts++
          $scope.product.isVoted=true
          $scope.product.vote=parseFloat(($scope.product.vote*($scope.product.vote_counts-1))+parseFloat($scope.currentVote))/$scope.product.vote_counts
          product.task = "vote"
          new Product(product).$update()
  ]