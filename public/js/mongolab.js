var mongolab;

mongolab = angular.module('mongolab', ['ngResource']);

mongolab.factory('Datapoint', function($resource) {
  var Datapoint;
  return Datapoint = $resource('api/datapoints/:id');
});

mongolab.factory('User', function($resource) {
  var User;
  return User = $resource('api/users/:id');
});
