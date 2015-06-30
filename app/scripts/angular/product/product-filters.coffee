module.exports = (angular)->
  'use strict'
  isInt = (field)->
    if (+field != field || field.indexOf(".") != -1)
      return false
    else
      return true
  angular.module("App.product.product-filters",[])
  .filter "persent",->
    (input) ->
      if input
        parseInt(input) * 20
  .filter "round2",->
    (input) ->
      if input
        parseInt(input * 100) / 100
  .filter "addZero",->
    (input) ->
      number=_.padRight(input,3,'.0');
      return number