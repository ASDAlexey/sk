module.exports = (angular)->
  'use strict'
  directive = angular.module('App.aside.aside-directives',[])
  directive.directive 'range',[
    "$timeout"
    ($timeout)->
      restrict : "E"
      template : require("./templates/range.jade")
      replace : true
      scope :
        floor : "="
        ceiling : "="
        step : "="
        handleLow : "="
        handleHeight : "="
        model : "="
      link : (scope,element,attrs) ->
        scope.model.floor = scope.floor
        scope.model.ceiling = scope.ceiling
        scope.model.step = scope.step
        scope.model.handleLow = scope.handleLow
        scope.model.handleHeight = scope.handleHeight
        scope.$watch 'handleLow',(data)->
          if data
            scope.model.handleLow = data
        scope.$watch 'handleHeight',(data)->
          if data
            scope.model.handleHeight = data
  ]
  directive.directive 'checkbox',[
    "$timeout"
    ($timeout)->
      restrict : "E"
      template : require("./templates/checkbox.jade")
      replace : true
      transclude : true
      scope :
        checked : "="
        model : "="
      controller : [
        "$scope"
        ($scope) ->
          $scope.switch = (model)->
            $scope.model = !model
      ]
      link : (scope,element,attrs) ->
        unless _.isUndefined(attrs.checked)
          scope.model = true
        else
          scope.model = false
  ]
  directive.directive 'color',[
    "$timeout"
    ($timeout)->
      restrict : "E"
      template : require("./templates/color.jade")
      replace : true
      transclude : true
      scope :
        checked : "="
        value : "@"
        model : "="
      controller : [
        "$scope"
        ($scope) ->
          $scope.switch = (model)->
            $scope.model = !model
      ]
      link : (scope,element,attrs) ->
        unless _.isUndefined(attrs.checked)
          scope.model = true
        else
          scope.model = false
  ]