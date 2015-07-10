module.exports = (angular)->
  'use strict'
  directive = angular.module('App.preloader.preloader-directives',[])
  directive.directive 'preloader',[
    "$timeout"
    "$window"
    "$rootScope"
    "$document"
    ($timeout,$window,$rootScope,$document)->
      restrict : "A"
      scope :
        preloader : "="
      link : (scope,element,attrs) ->
        $rootScope.persentLoaded = 0
        manifest = []
        isUnique = (el,array)->
          unless array.length
            return true
          isFound = 0
          array.forEach ((value,index) ->
            if value and el is value.src
              isFound = 1
          )
          if isFound
            return false
          else
            return true
        searchContainers = scope.preloader
        allElements = $document[0].querySelectorAll("body #{searchContainers[0]} *")
        angular.forEach allElements,(value,index)->
          urlString = $window.getComputedStyle(value).getPropertyValue('background-image')
          unless urlString is "none"
            if urlString.indexOf('url') + 1
              url = urlString
              url = url.replace(/url\(\"/g,"")
              url = url.replace(/url\(/g,"")
              url = url.replace(/\"\)/g,"")
              url = url.replace(/\)/g,"")
          else
            url = angular.element(value).attr("src")  if typeof (angular.element(value).attr("src")) isnt "undefined" and value.nodeName.toLowerCase() is "img"
          if url and isUnique(url,manifest)
            newSrc = {}
            newSrc.src = url
            manifest.push(newSrc)
        persentLast = 0
        persent = 0
        if $document[0].documentElement.classList.contains('ua-ie') then time=2000 else time=1000
        $timeout(->
          $document[0].documentElement.style.opacity = 1
        ,time)
        handleProgress = (event) ->
          if persent
            persentLast = persent
          persent = parseInt(event.loaded * 100)
          $rootScope.$broadcast('preloader:progress',
            persent : persent
          )
          $timeout(->
            TweenLite.to {d : persentLast},.5,
              d : persent
              roundProps : 'd'
              ease : Linear.easeNone
              onUpdate : ->
                $document[0].getElementById("persent-loaded").innerHTML = @target.d
          ,500)
        hidePreloader = ()->
          angular.element($document[0].querySelector('.svg-container-block')).addClass('page-is-loaded')
          $timeout(->
            angular.element($document[0].querySelector('.svg-container-block')).remove()
          ,1200)
        handleComplete = (event) ->
          $timeout(->
            TweenLite.to {d : persentLast},.5,
              d : 100
              roundProps : 'd'
              ease : Linear.easeNone
              onUpdate : ->
                $document[0].getElementById("persent-loaded").innerHTML = @target.d
          ,500)
          $rootScope.$broadcast('preloader:progress',
            persent : 100
          )
          $timeout(->
            $rootScope.$broadcast('preloader:loaded',
              loaded : true
            )
            hidePreloader()
          ,1000)
        preload = new createjs.LoadQueue(true)
        preload.on "progress",handleProgress
        preload.on "complete",handleComplete
        preload.loadManifest manifest,true
  ]
  directive.directive 'animatePreloader',[
    "$timeout"
    "$window"
    ($timeout,$window)->
      restrict : "A"
      link : (scope,element,attrs) ->
        boxLoader = document.getElementById('boxLoader')
        boxContainer = document.getElementById('boxContainer')
        box = document.getElementById('box')
        base = document.getElementById('base')
        TweenMax.set([boxLoader,base],{
          position : 'absolute',
          top : '50%',
          left : '50%',
          xPercent : -50,
          yPercent : -50
        })

        TweenMax.set([boxContainer],{
          position : 'absolute',
          top : '50%',
          left : '50%',
          xPercent : -50,
          yPercent : -50
        })

        tl = new TimelineMax({
          repeat : -1
        });

        tl.timeScale(1.2)

        tl.set(boxLoader,{
          transformOrigin : '0% 100%',
          left : '+=70',
          top : '-=' + 70 / 2
        })
        .to(boxLoader,1,{
            rotation : '-=90',
            ease : Power4.easeInOut
          })
        .set(boxLoader,{
            transformOrigin : '0% 100%',
            left : '-=70',
            rotation : 0
          })
        .to(boxLoader,1,{
            rotation : '-=90',
            ease : Power4.easeInOut
          })
        .set(boxLoader,{
            transformOrigin : '0% 100%',
            left : '-=70',
            rotation : 0
          })
        .to(boxLoader,1,{
            rotation : '-=270',
            ease : Power4.easeInOut
          })
        .to(boxContainer,1,{
            rotation : '+=180',
            ease : Back.easeInOut
          },'-=1')
        .set(boxLoader,{
            transformOrigin : '100% 0%',
            top : '+=70',
            rotation : 0
          })
        .to(boxLoader,1,{
            rotation : '-=90',
            ease : Power4.easeInOut
          })
        .set(boxLoader,{
            transformOrigin : '100% 0%',
            left : '+=70',
            rotation : 0
          })
        .to(boxLoader,1,{
            rotation : '-=90',
            ease : Power4.easeInOut
          })
        .set(boxLoader,{
            transformOrigin : '100% 0%',
            left : '+=70',
            rotation : 0
          })
        .to(boxLoader,1,{
            rotation : '-=270',
            ease : Power4.easeInOut
          })
        .to(boxContainer,1,{
            rotation : '+=180',
            ease : Back.easeInOut
          },'-=1')
  ]