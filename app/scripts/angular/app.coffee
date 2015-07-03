module.exports = (angular)->

  require('./preloader/preloader.coffee')(angular)
  require('./form/form.coffee')(angular)
  require('./svg/svg.coffee')(angular)
  require('./aside/aside.coffee')(angular)
  require('./animate/animate.coffee')(angular)
  require('./popup/popup.coffee')(angular)
  require('./drag/drag.coffee')(angular)
  require('./product/product.coffee')(angular)
  app = angular.module("App",[
    'ngAnimate'
    'ngCookies'
    'ui.mask'
    'validation.match'
    "isteven-multi-select"
    'angularAwesomeSlider'
    'App.animate'
    'App.preloader'
    'App.form'
    'App.aside'
    'App.popup'
    'App.drag'
    'App.product'
    'App.svg'
  ])
  app.run(($timeout,$rootScope)->
    $timeout(->
      $rootScope.load = true
    ,1500)
  )
  angular.bootstrap(document.getElementsByTagName("html"),["App"])