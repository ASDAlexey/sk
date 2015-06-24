module.exports = (angular,$)->
  'use strict'
  directive = angular.module('App.svg.svg-directives',[])
  directive.directive 'ngWidth',->
    (scope,element,attrs) ->
      scope.$watch attrs.ngWidth,(value) ->
        element.attr 'width',value
  directive.directive 'ngHeight',->
    (scope,element,attrs) ->
      scope.$watch attrs.ngHeight,(value) ->
        element.attr 'height',value
  directive.directive 'grayscaleImg',[
    "$timeout"
    "$window"
    ($timeout,$window)->
      restrict : "E"
      replace : true
      scope :
        url : "@"
        widthImg : "@"
        heightImg : "@"
      template : require('./templates/svg.jade')
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          scope.ww = $(window).width()
          scope.wh = $(window).height()
          angular.element($window).bind 'resize',->
            scope.ww = $(window).width()
            scope.wh = $(window).height()
          class GrayscaleCircle
            constructor : (data)->
              @time = data.time
              @src = data.src
              time : 0.8
              @canvas = data.canvas
              @canvas = Snap(@canvas)
              @property = data.property
              @imageBook(@src)
              @events(@property)
            property : ''
            src : ''
            filter : ''
            image : ''
            tw : ''
            imageBook : ->
              @image = @canvas.image(@src,0,0,@property.width,@property.height)
              @addGrayscaleFilter(@image,1)
            addGrayscaleFilter : (image,value)->
              @filter = @canvas.filter(Snap.filter.grayscale(value))
              image.attr(
                filter : @filter
              )
            events : ->
              filterChild = @filter.node.firstChild
              updateGrayScale = (tween) =>
                @addGrayscaleFilter(@image,1 - @tw.progress())
              @tw = new TimelineMax(onComplete : @complete)
              @tw.to(@image.node,.5,
                onUpdate : updateGrayScale
                onUpdateParams : ['{self}'])
              @tw.pause()
              $(element).parent().parent().on "mouseenter",=>
                @tw.play()
              $(element).parent().parent().on "mouseleave",=>
                @tw.reverse()
            circle : (property) ->
              'm ' + property.cx + ' ' + property.cy + ' m -' + property.r + ', 0 a ' + property.r + ',' + property.r + ' 0 1,0 ' + property.r * 2 + ',0 a ' + property.r + ',' + property.r + ' 0 1,0 -' + property.r * 2 + ',0'
          new GrayscaleCircle(
            canvas : $(element).get(0)
            time : 0.8
            src : scope.url
            widthImg : scope.widthImg
            heightImg : scope.heightImg
            property :
              cx : 163
              cy : 165
              r : 163
          )
  ]
  directive.directive 'poligonLink',[
    "$timeout"
    "$window"
    "$document"
    ($timeout,$window,$document)->
      restrict : "E"
      replace : true
      scope :
        text : "@",
        href : "@"
      template : require('./templates/poligon-link.jade')
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          class PoligonLink
            constructor : (data)->
              @canvas = data.canvas
              @canvas = Snap(@canvas)
              @property = data.property
              path = @canvas.path("M 298,46 L 298,0 L 200,0 L 164,46z")
              path.attr(
                x : 0
                y : 0
                fill : "#e7512a"
                stroke : "#ffffff",
                strokeWidth : 4
              )
              path.mouseover(->
                $document[0].querySelector('body').style.cursor = 'pointer'
              )
              path.mouseout(->
                $document[0].querySelector('body').style.cursor = 'default'
              )
              path.click(->
                $window.location.href = data.href
              )
              $(element).closest('.wrapper-img').on "mouseenter",->
                path.animate({d : "M 298,46 L 298,0 L 120,0 L 130,46z"},300,mina.easeout)
                text.animate({x : 174},300,mina.easeout)
              $(element).closest('.wrapper-img').on "mouseleave",->
                path.animate({d : "M 298,46 L 298,0 L 200,0 L 164,46z"},300,mina.easeout)
                text.animate({x : 200},300,mina.easeout)
              text = @canvas.text(200,29,data.text)
              text.attr(
                fill : "#ffffff"
              )
              text.mouseover(->
                $document[0].querySelector('body').style.cursor = 'pointer'
              )
              text.click(->
                $window.location.href = data.href
              )
          new PoligonLink(
            canvas : $(element).get(0)
            widthImg : 294
            heightImg : 46
            text : scope.text
            href : scope.href
          )
  ]
  directive.directive 'elacticButton',[
    "$timeout"
    "$window"
    "$document"
    ($timeout,$window,$document)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          extend = (a,b) ->
            for key of b
              if b.hasOwnProperty(key)
                a[key] = b[key]
            a
          SVGButton = (el,options) ->
            @el = el
            @options = extend({},@options)
            extend @options,options
            @init()
          SVGButton::options =
            speed :
              reset : 800
              active : 150
            easing :
              reset : mina.elastic
              active : mina.easein
          SVGButton::init = ->
            @shapeEl = @el.querySelector('span.morph-shape')
            s = Snap(@shapeEl.querySelector('.svg'))
            @pathEl = s.select('path')
            @paths =
              reset : @pathEl.attr('d')
              active : @shapeEl.getAttribute('data-morph-active')
            @initEvents()
          SVGButton::initEvents = ->
            @el.addEventListener 'mouseenter',@down.bind(this)
            @el.addEventListener 'mouseleave',@up.bind(this)
          SVGButton::down = ->
            @pathEl.animate {'path' : @paths.active},@options.speed.active,@options.easing.active
          SVGButton::up = ->
            @pathEl.animate {'path' : @paths.reset},@options.speed.reset,@options.easing.reset
          [].slice.call(document.querySelectorAll('.button.button--effect-2')).forEach (el) ->
            new SVGButton(el,
              speed :
                reset : 650
                active : 650
              easing :
                reset : mina.elastic
                active : mina.elastic)
  ]
  directive.directive 'svgMenu',[
    "$timeout"
    "$window"
    ($timeout,$window)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          SVGMenu = (el,options) ->
            @el = el
            @init()
          SVGMenu::init = ->
            @trigger = @el.querySelector('button.menu__handle')
            @shapeEl = @el.querySelector('div.morph-shape')
            s = Snap(@shapeEl.querySelector('svg'))
            @pathEl = s.select('path')
            @paths =
              reset : @pathEl.attr('d')
              open : @shapeEl.getAttribute('data-morph-open')
              close : @shapeEl.getAttribute('data-morph-close')
            @isOpen = false
            @initEvents()
          SVGMenu::initEvents = ->
            @trigger.addEventListener 'click',@toggle.bind(this)
          SVGMenu::toggle = ->
            self = this
            if @isOpen
              classie.remove self.el,'menu--anim'
              setTimeout (->
                classie.remove self.el,'menu--open'
              ),250
            else
              classie.add self.el,'menu--anim'
              setTimeout (->
                classie.add self.el,'menu--open'
              ),250
            @pathEl.stop().animate {'path' : if @isOpen then @paths.close else @paths.open},350,mina.easeout,->
              self.pathEl.stop().animate {'path' : self.paths.reset},800,mina.elastic
            @isOpen = !@isOpen
          new SVGMenu(document.getElementById('menu'))
  ]
  directive.directive 'progressCircle',[
    "$timeout"
    "$window"
    ($timeout,$window)->
      restrict : "E"
      replace : true
      template : require('./templates/progress-circle.jade')
      link : (scope,element,attrs) ->
        TweenMax.set(element[0].querySelector('.circle'),{drawSVG : '0% 0%'})
        scope.$on 'preloader:progress',(event,data) ->
#          TweenMax.fromTo(element[0].querySelector('.circle'),.7,{drawSVG : "0%"},{drawSVG : "#{data.persent}%"})
          TweenMax.to(element[0].querySelector('.circle'),.7,{drawSVG : "#{data.persent}%"})
  ]