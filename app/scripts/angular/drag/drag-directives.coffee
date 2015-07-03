module.exports = (angular,$)->
  'use strict'
  directive = angular.module('App.drag.drag-directives',[])
  directive.directive 'scroller',[
    "$timeout"
    "$window"
    "$rootScope"
    ($timeout,$window,$rootScope)->
      restrict : "E"
      replace : true
      scope :
        itemWidth : "@"
        countSlides : "@"
        direction : "@"
      link : (scope,element,attrs) ->
        scrollLeft = element[0].scrollLeft
        element[0].addEventListener('mousedown',->
          element.addClass('is-pointer-down')
          scrollLeft = element[0].scrollLeft
        )
        element[0].addEventListener('mouseup',(e)->
          element.removeClass('is-pointer-down')
          if element[0].scrollLeft is scrollLeft
            unless e.target.closest('.mini-cart-content')
              if e.target.closest('.wrapper-img')
                $window.location.href = e.target.closest('.wrapper-img').dataset.href
        )
        $timeout(->
          if element[0].parentNode.classList.contains('mini-cart-slider')
            element[0].parentNode.querySelectorAll('.switcher>li>a').forEach((el,index)->
              el.addEventListener('click',(e)->
                e.preventDefault()
                ect = e.currentTarget
                if ect.classList.contains('prev')
                  TweenMax.to(element[0],.7,{scrollTo : {y : "+=-87"}})
                if ect.classList.contains('next')
                  TweenMax.to(element[0],.7,{scrollTo : {y : "+=87"}})
              )
            )
        ,1000)
        scope.options =
          itemWidth : parseInt(scope.itemWidth)
          countSlides : parseInt(scope.countSlides)
        scope.$on 'toSlide',(event,data) ->
          if data.event.currentTarget.closest('.wrapper-scroller').querySelector('.scroller') == element[0]
            TweenMax.to(data.event.currentTarget.closest('.wrapper-scroller').querySelector('.scroller'),.7,{scrollTo : {x : parseInt(scope.itemWidth) * data.number}})
        scope.$on 'toSlideSwitch',(event,data) ->
          if data.event.currentTarget.closest('.wrapper-scroller').querySelector('.scroller') == element[0]
            if data.side is 'prev'
              number = parseInt(element[0].scrollLeft / scope.options.itemWidth) - 1
              if number > -2
                TweenMax.to(element[0],.7,{scrollTo : {x : parseInt(scope.itemWidth) * number}})
            if data.side is 'next'
              number = parseInt(element[0].scrollLeft / scope.options.itemWidth) + 1
              if number < scope.options.countSlides
                TweenMax.to(element[0],.7,{scrollTo : {x : parseInt(scope.itemWidth) * number}})
        dragStart = ()->
          if element[0].closest('.top-scroller,.product-scroller')
            $timeout(=>
              $rootScope.currentSlide = parseInt(-this.x / scope.options.itemWidth)
              $rootScope.$apply()
            ,500)
        dragEnd = ()->
          if element[0].closest('.top-scroller,.product-scroller')
            $timeout(=>
              $rootScope.currentSlide = parseInt(-this.x / scope.options.itemWidth)
              $rootScope.$apply()
            ,500)
        updatePosition = ()->
          if element[0].closest('.top-scroller,.product-scroller')
            $timeout(=>
              $rootScope.currentSlide = parseInt(-this.x / scope.options.itemWidth)
              $rootScope.$apply()
            ,500)
        if scope.direction is 'scrollTop'
          Draggable.create(element[0],
            {type : scope.direction,edgeResistance : .5,throwProps : true,lockAxis : true,onDragStart : dragStart,onDragEnd : dragEnd,onDrag : updatePosition})
        else
          Draggable.create(element[0],
            {type : scope.direction,edgeResistance : 1,throwProps : true,lockAxis : true,onDragStart : dragStart,onDragEnd : dragEnd,onDrag : updatePosition})
  ]