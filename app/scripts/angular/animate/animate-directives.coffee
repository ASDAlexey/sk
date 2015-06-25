module.exports = (angular,$)->
  'use strict'
  directive = angular.module('App.animate.animate-directives',[])
  directive.directive 'flipperX',[
    "$timeout"
    ($timeout)->
      restrict : "A"
      scope :
        flipperX : "@"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          CSSPlugin.defaultTransformPerspective = 1000
          TweenMax.set(element[0].querySelector('.back'),{rotationY : -180})
          frontCard = element[0].querySelector(".front")
          backCard = element[0].querySelector(".back")
          tl = new TimelineMax({paused : true})
          tl.to(frontCard,.7,{rotationY : 180}).to(backCard,.7,{rotationY : 0},0)
          if scope.flipperX is 'click'
            scope.$on 'change:auth',(event,response) ->
              if response.side is 'reg'
                tl.play()
              else if response.side is 'enter'
                tl.reverse()
          if scope.flipperX is 'hover'
            element[0].addEventListener 'mouseenter',->
              tl.play()
            element[0].addEventListener 'mouseleave',->
              tl.reverse()
  ]
  directive.directive 'rotate',[
    "$timeout"
    ($timeout)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          tl = new TimelineMax({repeat : -1});
          tl.to(element[0].querySelector('span'),2,{rotation : 360,ease : Linear.easeNone})
          tl.pause()
          element[0].addEventListener 'mouseenter',->
            tl.play()
          element[0].addEventListener 'mouseleave',->
            tl.pause()
  ]
  directive.directive 'flip3d',[
    "$timeout"
    ($timeout)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          CSSPlugin.defaultTransformPerspective = 1000
          frontCard = element[0].querySelector(".mini-cart-content")
          TweenMax.set(frontCard,{rotationX : -90,transformOrigin : "0 0 0"})
          tl = new TimelineMax({paused : true})
          tl.to(frontCard,.4,{rotationX : 0,transformOrigin : "0 0 0",ease : Sine.easeOut})
          element[0].addEventListener 'mouseenter',->
            element[0].classList.add('active')
            tl.play()
          element[0].querySelector('.close-small-cart').addEventListener 'click',->
            element[0].classList.remove('active')
            tl.reverse()
  ]
  directive.directive 'moveUp',[
    "$timeout"
    "$window"
    "$document"
    ($timeout,$window,$document)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          wh = $window.innerHeight
          scrollBlock = if($document[0].querySelector('body').scrollTop) then $document[0].querySelector('body') else $document[0].querySelector('html')
          windowScroll = ()->
            unless scrollBlock.scrollTop >= wh
              element[0].classList.add('no-visible')
            else
              element[0].classList.remove('no-visible')
          windowScroll()
          $window.addEventListener("scroll",windowScroll,false)
          element.bind 'click',->
            TweenMax.to(scrollBlock,.7,{scrollTop : 0})
  ]