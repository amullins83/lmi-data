var mongolab;

mongolab = angular.module('mongolab', ['ngResource']);

mongolab.factory('Data', function($resource) {
  var Data;
  return Data = $resource('api/data/:id');
});