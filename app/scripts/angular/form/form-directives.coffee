module.exports = (angular)->
  'use strict'
  directives = angular.module('App.form.form-directives',[])
  directives.directive 'deliveryForm',[
    "$timeout"
    ($timeout) ->
      restrict : "E"
      replace : true
      scope :
        dataForm : "=data"
      template : require('./templates/delivery-form.jade')
      link : (scope,element,attr)->
  ]
  directives.directive 'paymentForm',[
    "$timeout"
    ($timeout) ->
      restrict : "E"
      replace : true
      scope :
        dataForm : "=data"
        action : "@"
      template : require('./templates/payment-form.jade')
      link : (scope,element,attr)->
  ]
