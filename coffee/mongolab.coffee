# This is a module for cloud persistance in mongolab - https://mongolab.com
mongolab = angular.module 'mongolab', ['ngResource']

mongolab.factory 'Data', ($resource)->
    Data = $resource 'api/data/:id'