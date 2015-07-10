module.exports = (angular)->
  'use strict'
  services = angular.module("App.form.form-services",["ngResource"])
  services.factory 'ProductCart',($resource) ->
    $resource "#{window.location.protocol + "//" + window.location.hostname}:Id",{module : 'session',option : 'com_ajax',format : 'json',Id : '@Id'},'update' :method : 'PUT'
#    $resource "#{window.location.protocol + "//" + window.location.hostname}:Id",{module : 'session',option : 'com_ajax',format : 'json',Id : '@Id'},
#      update :
#        method : 'PUT'