directives = angular.module "lmiData.directives", []

directives.directive "editOnClick", ->
    (scope, elem, attrs)->
        elem.click ->
            elem.siblings().removeClass "editing"
            elem.addClass "editing"
            scope.editDataItem = scope.dataById elem.data "_id"
