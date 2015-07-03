module.exports = (angular)->
  'use strict'
  isInt = (field)->
    if (+field != field || field.indexOf(".") != -1)
      return false
    else
      return true
  angular.module("App.product.product-filters",[])
  .filter "splitSpace",->
    (input) ->
      if input
        input.toString().replace(/(\d)(?=(\d\d\d)+([^\d]|$))/g,'$1 ')
  .filter "persent",->
    (input) ->
      if input is 0
        return 0
      if input
        parseFloat(input) * 20
  .filter "round2",->
    (input) ->
      if input
        parseInt(input * 100) / 100
  .filter "addZero",->
    (input) ->
      unless input
        number = '0.0'
      else
        number = _.padRight(input,3,'.0');
      return number