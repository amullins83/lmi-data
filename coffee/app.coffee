'use strict'

# Declare app level module which depends on filters, and services

app = angular.module('lmiData', [
    'lmiData.filters'
    'lmiData.directives'
    'ui'
    'ui.bootstrap'
    'ui.bootstrap.dialog'
    'mongolab'
]).config [
    '$routeProvider'
    '$locationProvider'
    ($routeProvider, $locationProvider)->
        $routeProvider.when('/data', {templateUrl: 'partials/data', controller: DataCtrl})
        $routeProvider.otherwise({redirectTo: '/data'})
        $locationProvider.html5Mode(true)
]
