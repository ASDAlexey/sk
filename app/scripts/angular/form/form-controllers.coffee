module.exports = (angular,$)->
  'use strict'
  controller = angular.module("App.form.form-controllers",[])
  controller.controller "SearchCtrl",[
    "$scope"
    "$http"
    "$rootScope"
    "$timeout"
    "$window"
    ($scope,$http,$rootScope,$timeout,$window) ->
      $scope.blurSearch = (search)->
        unless search
          $scope.isOpenSearch = false
  ]
  controller.controller "MiniCart",[
    "$scope"
    "$rootScope"
    ($scope,$rootScope) ->
      $scope.$on 'cart:changed',(event,response) ->
        $scope.products = response.data.products
      $scope.delete = (product)->
        $rootScope.$broadcast('product:delete',
          data : product
        )
        $scope.products = _.without($scope.products,product)
      $scope.resultSum = (products)->
        _.sum products,(product) ->
          parseInt(product.quantity) * parseFloat(product.product_price)
  ]
  controller.controller "FormAuthCtrl",[
    "$scope"
    "$http"
    "$rootScope"
    "$timeout"
    "$window"
    ($scope,$http,$rootScope,$timeout,$window) ->
      $scope.form_set_dirty = (form) ->
        if form.$setDirty
          form.$setDirty()
          angular.forEach form,(input,key) ->
            if typeof input is 'object' and input.$name isnt `undefined`
              form[input.$name].$setViewValue (if form[input.$name].$viewValue isnt `undefined` then form[input.$name].$viewValue else "")
      #show pwd
      $scope.isPwdShow = false
      $scope.type = "password"
      $scope.switch = (side)->
        $rootScope.$broadcast('change:auth',
          side : side
        )
      $scope.determineType = (condition)->
        $scope.isPwdShow = !condition
        if !condition
          $scope.type = "text"
        else
          $scope.type = "password"
      $scope.changeShowPsw = (pwd)->
        $scope.isPwdShow = !pwd
      $scope.changeShowRePsw = (pwd)->
        $scope.isRePwdShow = !pwd
      $scope.send = (dataForm,formValidate,action,form)=>
        if formValidate.$valid
          if form is 'edit-pwd'
            angular.element(document.getElementById(form))[0].submit()
          else
            angular.element(document.getElementById(form))[0].submit()
        else
          $scope.form_set_dirty(formValidate)
  ]
  controller.controller "SubscribeCtrl",[
    "$scope"
    "$http"
    "$rootScope"
    "$timeout"
    ($scope,$http,$rootScope,$timeout) ->
      $rootScope.formIsValide = false
      $scope.form_set_pristine = (form) ->
        if form.$setPristine
          form.$setPristine()
      $scope.form_set_dirty = (form) ->
        if form.$setDirty
          form.$setDirty()
          angular.forEach form,(input,key) ->
            if typeof input is 'object' and input.$name isnt `undefined`
              form[input.$name].$setViewValue (if form[input.$name].$viewValue isnt `undefined` then form[input.$name].$viewValue else "")
      $scope.send = (dataForm,formValidate,action)=>
        if formValidate.$valid
          $scope.thanksShowTime()
          sendOptions =
            action : action
            method : "POST"
            data : angular.copy(dataForm)
          $scope.clear(formValidate)
          $scope.sendData(sendOptions)
        else
          $scope.form_set_dirty(formValidate)
      $scope.clear = (formValidate)=>
        $scope.dataForm.data = {}
        $scope.form_set_pristine(formValidate)
      $rootScope.hideThank = ()->
        $rootScope.formIsValide = false
      $scope.thanksShowTime = ()->
        $rootScope.formIsValide = true
        $timeout(->
          $rootScope.hideThank()
        ,2000)
      $scope.sendData = (sendOptions)->
        $http(
          url : sendOptions.action
          method : sendOptions.method
          data : sendOptions.data
        ).then(->
          $scope.clear(formValidate)
        )
  ]
  controller.controller "RecallCtrl",[
    "$scope"
    "$http"
    "$rootScope"
    "$timeout"
    ($scope,$http,$rootScope,$timeout) ->
      $rootScope.formIsValide = false
      $scope.form_set_pristine = (form) ->
        if form.$setPristine
          form.$setPristine()
      $scope.form_set_dirty = (form) ->
        if form.$setDirty
          form.$setDirty()
          angular.forEach form,(input,key) ->
            if typeof input is 'object' and input.$name isnt `undefined`
              form[input.$name].$setViewValue (if form[input.$name].$viewValue isnt `undefined` then form[input.$name].$viewValue else "")
      $scope.send = (dataForm,formValidate,action)=>
        if formValidate.$valid
          $scope.thanksShowTime()
          sendOptions =
            action : action
            method : "POST"
            data : angular.copy(dataForm)
          $scope.clear(formValidate)
          $scope.sendData(sendOptions)
        else
          $scope.form_set_dirty(formValidate)
      $scope.clear = (formValidate)=>
        $scope.dataForm.data = {}
        $scope.form_set_pristine(formValidate)
      $rootScope.hideThank = ()->
        $rootScope.formIsValide = false
      $scope.thanksShowTime = ()->
        $rootScope.formIsValide = true
        $timeout(->
          $rootScope.hideThank()
        ,2000)
      $scope.sendData = (sendOptions)->
        $http(
          url : sendOptions.action
          method : sendOptions.method
          data : sendOptions.data
        ).then(->
          $scope.clear(formValidate)
        )
  ]
  controller.controller "FormCtrl",[
    "$scope"
    "$http"
    "$rootScope"
    "$timeout"
    "$window"
    "$document"
    ($scope,$http,$rootScope,$timeout,$window,$document) ->
      $scope.form_set_pristine = (form) ->
        if form.$setPristine
          form.$setPristine()
      $scope.form_set_dirty = (form) ->
        if form.$setDirty
          form.$setDirty()
          angular.forEach form,(input,key) ->
            if typeof input is 'object' and input.$name isnt `undefined`
              form[input.$name].$setViewValue (if form[input.$name].$viewValue isnt `undefined` then form[input.$name].$viewValue else "")
      $scope.scrollTopPayment = ()->
        scrollBlock = if($document[0].querySelector('body').scrollTop) then $document[0].querySelector('body') else $document[0].querySelector('html')
        paymentBlockTop = $document[0].getElementById('payment').offsetTop
        TweenMax.to(scrollBlock,.7,{scrollTop : paymentBlockTop})
      $scope.send = (dataForm,formValidate,nameForm,action)=>
        if formValidate.$valid
          if nameForm is 'delivery'
            $scope.scrollTopPayment()
          else
            $scope.thanksShowTime()
            sendOptions =
              action : action
              method : "POST"
              data : angular.copy(dataForm)
            $scope.sendData(sendOptions)
            $scope.clear(formValidate)
        else
          $scope.form_set_dirty(formValidate)
      $scope.clear = (formValidate)=>
        $scope.dataForm.data = {}
        $scope.form_set_pristine(formValidate)
      $rootScope.hideThank = ()->
        $rootScope.formIsValide = false
      $scope.thanksShowTime = ()->
        $rootScope.formIsValide = true
        $timeout(->
          $rootScope.hideThank()
        ,2000)
      $scope.sendData = (sendOptions)->
        $http(
          url : sendOptions.action
          method : sendOptions.method
          data : sendOptions.data
        ).then(->
          $scope.clear(formValidate)
        )
  ]
  controller.controller "CartCtrl",[
    "$scope"
    "$http"
    "$rootScope"
    "$timeout"
    "Product"
    ($scope,$http,$rootScope,$timeout,Product) ->
#calc cart
      $scope.changeQuantity = (product,direction)->
        if direction is 'increment'
          product.quantity++
        if direction is 'decrement' and product.quantity > 1
          product.quantity--
      $scope.delete = (product)->
        $scope.cart.products = _.without($scope.cart.products,product)
        new Product(product).$update()
      $scope.$on 'product:delete',(event,response) ->
        $scope.delete(response.data)
      $scope.resultSum = (products)->
        _.sum products,(product) ->
          parseInt(product.quantity) * parseFloat(product.product_price)
      #validation
      $rootScope.formIsValide = false
      $scope.form_set_pristine = (form) ->
        if form.$setPristine
          form.$setPristine()
      $scope.form_set_dirty = (form) ->
        if form.$setDirty
          form.$setDirty()
          angular.forEach form,(input,key) ->
            if typeof input is 'object' and input.$name isnt `undefined`
              form[input.$name].$setViewValue (if form[input.$name].$viewValue isnt `undefined` then form[input.$name].$viewValue else "")
      $scope.send = (dataForm,formValidate,action)=>
        if formValidate.$valid
          $scope.thanksShowTime()
          sendOptions =
            action : action
            method : "POST"
            data : angular.copy(dataForm)
          $scope.clear(formValidate)
          $scope.sendData(sendOptions)
        else
          $scope.form_set_dirty(formValidate)
      $scope.clear = (formValidate)=>
        $scope.dataForm.data = {}
        $scope.form_set_pristine(formValidate)
      $rootScope.hideThank = ()->
        $rootScope.formIsValide = false
      $scope.thanksShowTime = ()->
        $rootScope.formIsValide = true
        $timeout(->
          $rootScope.hideThank()
        ,2000)
      $scope.sendData = (sendOptions)->
        $http(
          url : sendOptions.action
          method : sendOptions.method
          data : sendOptions.data
        ).then(->
          $scope.clear(formValidate)
        )
      $scope.$watch 'cart',((newVal,oldVal) ->
        if !angular.equals(newVal,oldVal)
          $rootScope.$broadcast('cart:changed',
            data : newVal
          )
      ),true
  ]