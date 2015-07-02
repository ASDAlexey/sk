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
  controller.controller "FormAuthCtrl",[
    "$scope"
    "$http"
    "$rootScope"
    "$timeout"
    "$window"
    "Video"
    ($scope,$http,$rootScope,$timeout,$window,Video) ->
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
        $scope.videos = Video.query()
        $scope.videos.$promise.then((data)->
        )
        if formValidate.$valid
          angular.element(document.getElementById(form)).submit()
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
    ($scope,$http,$rootScope,$timeout) ->
      $rootScope.formIsValide = false
      #custom select
      $scope.addSelects = ()->
        resultSelects = []
        angular.forEach $scope.selects,(value,key)->
          if _.findWhere(value,{'ticked' : true}).value
            resultSelects.push {
              "name" : key
              "value" : _.result(_.findWhere(value,{'ticked' : true}),'value')
            }
        if resultSelects.length
          return resultSelects
        else
          return false
      $scope.setCountSelects = ()->
        $scope.zIndex = new Array(1)
        $scope.zIndex = _.fill($scope.zIndex,false)
      $scope.fOpen = (number)->
        $scope.zIndex[number] = true
      $scope.fClose = (number)->
        $scope.zIndex[number] = false
        if $scope.addSelects()
          $scope.dataForm.data.selects = $scope.addSelects()
      $scope.selects = {}
      $scope.setSelect = (selectObj,isLast = false)->
        $scope.selects[selectObj.name] = []
        $scope.selects[selectObj.name].push {
          name : selectObj.placeholder.text
          value : selectObj.placeholder.value
          maker : ""
          ticked : true
        }
        angular.forEach selectObj.options,(value,key)->
          unless selectObj.placeholder.text is value.text
            $scope.selects[selectObj.name].push {
              name : value.text
              value : value.value
              maker : ""
              ticked : false
            }

        console.log($scope.selects)
#        if isLast
#          console.log('last')
#          console.log($scope.selects)
#          if $scope.addSelects()
#            $scope.selectsCollection = $scope.addSelects()
#            console.log($scope.selectsCollection)
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
          if $scope.addSelects()
            dataForm.data.selects = $scope.addSelects()
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
  controller.controller "CartCtrl",[
    "$scope"
    "$http"
    "$rootScope"
    "$timeout"
    ($scope,$http,$rootScope,$timeout) ->
      $scope.cart = {}
      $scope.cart.delivery = {}
      $scope.cart.delivery.asd = 1
      #calc cart
      $scope.changeQuantity = (product,direction)->
        if direction is 'increment'
          product.quantity++
        if direction is 'decrement' and product.quantity > 1
          product.quantity--
      $scope.delete = (product)->
        $scope.cart.products = _.without($scope.cart.products,product)
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
  ]