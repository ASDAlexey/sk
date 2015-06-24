module.exports = (angular,$)->
  'use strict'
  directive = angular.module('App.animate.animate-directives',[])
  directive.directive 'flipperX',[
    "$timeout"
    ($timeout)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          CSSPlugin.defaultTransformPerspective = 1000
          TweenMax.set(element[0].querySelector('.back'),{rotationY : -180})
          frontCard = element[0].querySelector(".front")
          backCard = element[0].querySelector(".back")
          tl = new TimelineMax({paused : true})
          tl.to(frontCard,.7,{rotationY : 180}).to(backCard,.7,{rotationY : 0},0)
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
  directive.directive 'flip3d',[    "$timeout"
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
#  directive.directive 'rotateY',[
#    "$timeout"
#    "$window"
#    ($timeout,$window)->
#      restrict : "A"
#      scope :
#        rotateY : "@"
#      link : (scope,element,attrs) ->
#        angular.element(document).ready ->
#          tl = new TimelineMax({paused : true})
#          tl.to($(element),3,{rotationY : scope.rotateY,transformOrigin : "50% 50% 0",ease : Back.easeOut})
#          $(element).on 'mouseenter',->
#            $timeout(->
#              tl.play()
#            ,50)
#          $(element).on 'mouseleave',->
#            tl.reverse()
#  ]
#
#  directive.directive 'fadein3d',[
#    "$timeout"
#    "$window"
#    ($timeout,$window)->
#      restrict : "A"
#      link : (scope,element,attrs) ->
#        angular.element(document).ready ->
#          unless document.querySelector('html').classList.contains('ua-mobile')
#            tl = new TimelineMax({paused : true})
#            tl.staggerFrom($(element).find('>*'),0.8,{opacity : 0,scale : 0,y : 80,rotationX : 180,transformOrigin : "0% 50% -50",ease : Back.easeOut},0.1,"+=0")
#            animationParameters = ->
#              offsetTop = $(element).closest('section,article').offset().top
#              scrollTop = $($window).scrollTop()
#              wh = $($window).height()
#              if(offsetTop - scrollTop) <= wh / 2
#                tl.play()
#              else
#                tl.reverse()
#            animationParameters()
#            $($window).scroll(->
#              animationParameters()
#            )
#  ]
#  directive.directive 'fadeinleft',[
#    "$timeout"
#    "$window"
#    ($timeout,$window)->
#      restrict : "A"
#      link : (scope,element,attrs) ->
#        angular.element(document).ready ->
#          unless document.querySelector('html').classList.contains('ua-mobile')
#            tl = new TimelineMax({paused : true})
#            tl.staggerFrom($(element).find('>*'),0.8,{opacity : 0,scale : 0,x : -80,rotationY : -180,transformOrigin : "0% 50% 50%",ease : Back.easeOut},0.1,"+=0")
#            animationParameters = ->
#              offsetTop = $(element).closest('section,article').offset().top
#              scrollTop = $($window).scrollTop()
#              wh = $($window).height()
#              if(offsetTop - scrollTop) <= wh / 2
#                tl.play()
#              else
#                tl.reverse()
#            animationParameters()
#            $($window).scroll(->
#              animationParameters()
#            )
#  ]
#  directive.directive 'showAnimations',[
#    "$timeout"
#    "$document"
#    ($timeout,$document)->
#      restrict : "A"
#      link : (scope,element,attrs) ->
#        angular.element($document).ready ->
#          tmax_options = {
#            paused : true
#            onStart : ->
#              element[0].querySelector('.info-block').classList.add('show')
#            onReverseComplete : ->
#              element[0].querySelector('.info-block').classList.remove('show')
#          }
#          tl = new TimelineMax(tmax_options)
#          tl.from(element[0].querySelector('.info-block'),.3,{opacity : 0,y : "-100%"})
#          element[0].addEventListener 'mouseenter',->
#            tl.play()
#          element[0].addEventListener 'mouseleave',->
#            tl.reverse()
#  ]
#  directive.directive 'bond',[
#    "$timeout"
#    "$document"
#    "$window"
#    ($timeout,$document,$window)->
#      restrict : "A"
#      link : (scope,element,attrs) ->
#        angular.element($document).ready ->
#          $timeout(->
#            $(element).bond()
#          ,0)
#  ]
#  directive.directive 'transitionShow',[
#    "$timeout"
#    "$document"
#    ($timeout,$document)->
#      restrict : "A"
#      link : (scope,element,attrs) ->
#        angular.element($document).ready ->
#          tmax_options = {
#            paused : true
#          }
#          tl = new TimelineMax(tmax_options)
#          tl.from(element[0].querySelectorAll('img')[1],.3,{opacity : 0})
#          element[0].addEventListener 'mouseenter',->
#            tl.play()
#          element[0].addEventListener 'mouseleave',->
#            tl.reverse()
#  ]
#  directive.directive 'slitSlider',[
#    ()->
#      restrict : "A"
#      scope :
#        time : "@"
#      link : (scope,element,attr)->
##        #Автопереключение слайдера
##        timeoutId = ''
#        goInt = ->
#          $('#nav-arrows .nav-arrow-next').trigger('click')
#          return
#        #        onInt = ->
#        #          timeoutId = setInterval(goInt,time)
#        #          return
#        #        offInt = ->
#        #          clearInterval timeoutId
#        #          return
#        #Генератор случайных чисел
#        getRandomNumber = (begin,end)->
#          return Math.random() * (end - begin + 1)
#        document.body.addEventListener "keydown",(e) ->
#          if (e.keyCode is 83) and (e.ctrlKey)
#            e.preventDefault()
#            $('body').remove()
#          return
#        document.body.addEventListener "keydown",(e) ->
#          if (e.keyCode is 85) and (e.ctrlKey)
#            e.preventDefault()
#            $('body').remove()
#          return
#        time = scope.time
#        Page = (->
#          $navArrows = $("#nav-arrows")
#          $nav = $("#nav-dots > span")
#          slitslider = $("#slider").slitslider(onBeforeChange : (slide,pos) ->
#            $nav.removeClass "nav-dot-current"
#            $nav.eq(pos).addClass "nav-dot-current"
#            if $('.slide-rounds .active').index() isnt $('.slide-rounds li:last-child').index()
#              $('.slide-rounds .active').next().trigger('click')
#            else
#              $('.slide-rounds li:first-child').trigger('click')
#            #            offInt()
#            #            onInt()
#            return
#          )
#          init = ->
#            initEvents()
#            return
#          initEvents = ->
#            $navArrows.children(":last").on "click",->
#              slitslider.next()
#              false
#            $navArrows.children(":first").on "click",->
#              slitslider.previous()
#              false
#            $nav.each (i) ->
#              $(this).on "click",(event) ->
#                $dot = $(this)
#                unless slitslider.isActive()
#                  $nav.removeClass "nav-dot-current"
#                  $dot.addClass "nav-dot-current"
#                slitslider.jump i + 1
#                false
#              return
#            return
#          init : init)()
#        Page.init()
#  ]