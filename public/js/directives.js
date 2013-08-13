var directives;

directives = angular.module("lmiData.directives", []);

directives.directive("editOnClick", function() {
  var numOutputRows;
  numOutputRows = 0;
  return function(scope, elem, attrs) {
    elem.data("_id", numOutputRows);
    numOutputRows += 1;
    return elem.click(function() {
      elem.siblings().removeClass("editing");
      elem.addClass("editing");
      scope.editDataItem = elem.data("_id");
      return scope.populateForm();
    });
  };
});

directives.directive("inputRow", function() {
  var numInputFields;
  numInputFields = 0;
  return function(scope, elem, attrs) {
    var template;
    template = attrs.template || ("<div class='col-lg-2 textRight ng-binding'> " + scope.dataFields[numInputFields] + " </div> ") + ("<input class='col-lg-3' ng-model=\"" + scope.dataFields[numInputFields] + "\" />");
    elem.append(template);
    return numInputFields += 1;
  };
});
