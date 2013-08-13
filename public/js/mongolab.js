var mongolab;

mongolab = angular.module('mongolab', ['ngResource']);

mongolab.factory('Datapoint', function($resource) {
  var Datapoint;
  return Datapoint = $resource('api/datapoints/:id');
});
