module.exports = (angular)->
  'use strict'
  angular.module("App.form.form-filters",[])
  .filter "splitSpace",->
    (input) ->
      if input
        input.toString().replace(/(\d)(?=(\d\d\d)+([^\d]|$))/g,'$1 ')
  .filter "persent",->
    (input) ->
      if input
        input * 100
  .filter "toMb",->
    (input) ->
      if input
        Math.round(input * 100 / 1048576) / 100
  .filter "toArr0",->
    (input) ->
      if input
        input.split(';')[0]
  .filter "toArr1",->
    (input) ->
      if input
        input.split(';')[1]