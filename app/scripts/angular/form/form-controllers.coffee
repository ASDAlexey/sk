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
    "ProductCart"
    "$http"
    ($scope,$rootScope,ProductCart,$http) ->
      $scope.$on 'cart:changed',(event,response) ->
        if response.data.length
          $scope.products = response.data
      $scope.delete = (product)->
        product.task = "cartDelete"
        ProductCart.delete(product)
        $scope.products = _.without($scope.products,product)
        $rootScope.$broadcast('product:delete',
          data : product
          products : $scope.products
          name : 'minicart'
          productsQ : _.sum $scope.products,(productEl) ->
            parseInt(productEl.quantity)
        )
      $scope.setProductsArr = (arr)->
        $scope.products = arr
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
      $scope.resultSum = (products)->
        _.sum products,(product) ->
          parseInt(product.quantity) * parseFloat(product.product_price)
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
    "ProductCart"
    ($scope,$http,$rootScope,$timeout,ProductCart) ->
#calc cart
      $scope.changeQuantity = (product,direction)->
        product.task = 'cartUpdate'
        if direction is 'increment'
          product.quantity++
          ProductCart.update({task : 'cartUpdate',quantity : product.quantity,virtuemart_product_id : product.virtuemart_product_id},product)
        if direction is 'decrement' and product.quantity > 1
          product.quantity--
          ProductCart.update({task : 'cartUpdate',quantity : product.quantity,virtuemart_product_id : product.virtuemart_product_id},product)
        $rootScope.$broadcast('cart:changed',
          data : $scope.cart.products
        )
      $scope.delete = (product,name = '')->
        $scope.cart.products = _.without($scope.cart.products,product)
        unless name is 'minicart'
          product.task = "cartDelete"
          ProductCart.delete(product)
          $rootScope.$broadcast('cart:changed',
            data : $scope.cart.products
          )
      $scope.$on 'product:delete',(event,response) ->
        $scope.cart.products = response.products
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
#      $scope.$watch 'cart.products',((newVal,oldVal) ->
#        if !angular.equals(newVal,oldVal)
#          console.log(newVal)
#          #          if _.isObject(newVal)
#          #            console.log(newVal)
#          #            arr = []
#          #            angular.forEach newVal,(el,key) ->
#          #              console.log('ssss')
#          #              console.log(el)
#          #              if el
#          #                arr.push el[0]
#          #            console.log('////')
#          #            console.log(_.compact(arr))
#          $rootScope.$broadcast('cart:changed',
#            data : newVal
#          )
#      ),true
  ]