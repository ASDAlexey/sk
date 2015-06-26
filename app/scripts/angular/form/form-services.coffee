module.exports = (angular)->
  'use strict'
  services = angular.module("App.form.form-services",["ngResource"])
  services.factory 'Video',($resource) ->
    $resource '/json/catalog.json/:Id',{Id : '@Id'},'update' :method : 'PUT'