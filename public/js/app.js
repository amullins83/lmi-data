'use strict';
var app;

app = angular.module('lmiData', ['lmiData.filters', 'lmiData.directives', 'ui', 'ui.bootstrap', 'ui.bootstrap.dialog', 'mongolab']).config([
  '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider.when('/data', {
      templateUrl: 'partials/data',
      controller: DataCtrl
    });
    $routeProvider.otherwise({
      redirectTo: '/data'
    });
    return $locationProvider.html5Mode(true);
  }
]);
