module.exports = (angular)->
  'use strict'
  require('./product-filters.coffee')(angular)
  require('./product-controllers.coffee')(angular)
  require('./product-services.coffee')(angular)
  angular.module("App.product",[
    "App.product.product-filters"
    "App.product.product-controllers"
    "App.product.product-services"
  ])