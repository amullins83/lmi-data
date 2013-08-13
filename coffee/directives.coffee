directives = angular.module "lmiData.directives", []

directives.directive "editOnClick", ->
    numOutputRows = 0
    (scope, elem, attrs)->
        elem.data "_id", numOutputRows
        numOutputRows += 1
        elem.click ->
            elem.siblings().removeClass "editing"
            elem.addClass "editing"
            scope.editDataItem = elem.data "_id"
            scope.populateForm()

directives.directive "inputRow", ->
    numInputFields = 0
    (scope, elem, attrs)->
        template = attrs.template or
        "<div class='col-lg-2 textRight ng-binding'> #{scope.dataFields[numInputFields]} </div> " +
        "<input class='col-lg-3' ng-model=\"#{scope.dataFields[numInputFields]}\" />" 
        
        elem.append template

        numInputFields += 1
