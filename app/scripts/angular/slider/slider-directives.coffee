module.exports = (angular,$)->
  'use strict'
  directive = angular.module('App.slider.slider-directives',[])
  directive.directive 'groupSlider',[
    "$timeout"
    "$document"
    ($timeout,$document)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element($document).ready ->
          tmax_options = {
            paused : true
#            onStart : ->
#              element[0].querySelector('.info-block').classList.add('show')
#            onReverseComplete : ->
#              element[0].querySelector('.info-block').classList.remove('show')
          }

          scope.$on 'switchGroup',(event,data) ->
            TweenMax.to(element[0],.7,{x : -940*data.numberCurrentGroup})
#          scope.$on('switchGroup',
#            numberCurrentGroup : $scope.currentGroup
#          )
#          $document[0].querySelector('.switch-slider-news .prev').addEventListener 'click',->
#            TweenMax.to(element[0],.7,{x : -940})
#          $document[0].querySelector('.switch-slider-news .next').addEventListener 'click',->
#            TweenMax.to(element[0],.7,{x : 0})
  ]