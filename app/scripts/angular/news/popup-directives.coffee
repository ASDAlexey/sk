module.exports = (angular)->
  'use strict'
  directive = angular.module('App.news.news-directive',[])
  directive.directive 'contentNews',[
    ()->
      restrict : "A"
      link : (scope,element,attrs) ->
        scope.$on 'addNews',(event,data) ->
          element[0].innerHTML = data.content
        scope.$on 'switchActiveNews',(event,data) ->
          currentList = data.event.currentTarget.closest('li')
          unless currentList.classList.contains('active')
            currentList.parentNode.getElementsByClassName('active')[0].classList.remove('active')
            currentList.classList.add('active')
  ]