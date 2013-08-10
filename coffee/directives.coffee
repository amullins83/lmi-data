directives = angular.module "lmiData.directives", []

directives.directive "autoColor", ->
    (scope, elem, attrs)->
        textColor = attrs["textColor"] or "#ddd"
        posColor = attrs["posColor"] or "#8f8"
        negColor = attrs["negColor"] or "#f84"
        neutralColor = attrs["neutralColor"] or "#fff"
        if isNaN elem.text()
            elem.css background: textColor
        else if parseInt(elem.text(), 10) > 0
            elem.css background: posColor
        else if parseInt(elem.text(), 10) < 0
            elem.css background: negColor
        else
            elem.css background: neutralColor

directives.directive "editOnClick", ->
    (scope, elem, attrs)->
        elem.click ->
            elem.siblings().removeClass "editing"
            elem.addClass "editing"
            scope.editDataItem = scope.data[parseInt elem.find(".col-lg-1:first-child").text(), 10]
