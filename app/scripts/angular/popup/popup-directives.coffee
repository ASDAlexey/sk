module.exports = (angular)->
  'use strict'
  directive = angular.module('App.popup.popup-directive',[])
  directive.directive 'rotate',[
    "$timeout"
    ($timeout)->
      restrict : "A"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          tl = new TimelineMax({repeat : -1});
          tl.to(element[0].getElementsByTagName('span')[0],2,{rotation : 360,ease : Linear.easeNone})
          tl.pause()
          element[0].addEventListener('mouseenter',->
            tl.play()
          )
          element[0].addEventListener('mouseleave',->
            tl.pause()
          )
  ]
  directive.directive 'popupSvg',[
    '$timeout'
    ($timeout) ->
      restrict : 'E'
      replace : true
      transclude : true
      template : require('./templates/popup-svg.jade')
      controller : [
        "$scope"
        "$rootScope"
        ($scope,$rootScope) ->
          $scope.closePopup = (msg,data) ->
            $rootScope.$broadcast 'popup',
              data : data
              msg : msg
              isOpened : false
      ]
      scope :
        name : "@"
      link : (scope,element,attrs) ->
        angular.element(document).ready ->
          element[0].classList.remove 'hide-block'
          #popup events Listener
          scope.$on 'popup',(event,response) ->
            if response.isOpened
              if response.msg is scope.name
                openOverlay()
            else if !response.isOpened
              closeOverlay()
          overlay = element[0]
          tl = {}
          tl[scope.name] = new TimelineMax(paused : true)
          $timeout (->
            choise = _.union(element[0].getElementsByClassName('inner-popup'),element[0].getElementsByClassName('overlay-close'),
              element[0].getElementsByClassName('logo'))
            tl[scope.name].staggerFrom choise,0.7,{
              opacity : 0
              scale : 0
              y : 80
              rotationX : 180
              transformOrigin : '0% 50% -50'
              ease : Back.easeOut
            },0.1,'+=0'
          ),100
          openOverlay = ->
            overlay.classList.add('open')
            path.animate {'path' : pathConfig.to},800,mina.easeout
            $timeout (->
              tl[scope.name].play()
            ),800
          closeOverlay = ->
            tl[scope.name].reverse()
            $timeout (->
              path.animate {'path' : pathConfig.from},500,mina.easeout
              $timeout (->
                overlay.classList.remove('open')
              ),500
            ),500
          s = Snap(overlay.querySelector('svg'))
          path = s.select('path')
          pathConfig =
            from : path.attr('d')
            to : overlay.getAttribute('data-path-to')
  ]