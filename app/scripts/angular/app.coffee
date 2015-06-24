module.exports = (angular,Snap)->
#  require('./preloader/preloader.coffee')(angular)
  require('./form/form.coffee')(angular)
  #  require('../plugins/angular-parallax.js')(angular)
  #  require('./tabs/tabs.coffee')(angular)
  #  require('./slider/slider.coffee')(angular)
  #  require('./map/map.coffee')(angular)
  #  require('./svg/svg.coffee')(angular)
  #  require('./aside/aside.coffee')(angular,$)
  require('./animate/animate.coffee')(angular)
  #  require('./news/news.coffee')(angular,$)
  #  require('./popup/popup.coffee')(angular)
  require('./drag/drag.coffee')(angular)
  app = angular.module("App",[
    'ngAnimate'
#    'uiGmapgoogle-maps'
#    'ui.mask'
    'multi-select'
    'App.animate'
#    'angular-parallax'
#    'App.preloader'
    'App.form'
#    'App.tabs'
#    'App.slider'
#    'App.svg'
#    'App.map'
#    'App.aside'
#    'App.popup'
#    'App.news'
    'App.drag'
  ])
  app.run(($timeout,$rootScope)->
    $timeout(->
      $rootScope.load = true
    ,1500)
  )
  angular.bootstrap(document.getElementsByTagName("html"),["App"])