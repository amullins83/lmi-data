var directives;

directives = angular.module("lmiData.directives", []);

directives.directive("editOnClick", function() {
  return function(scope, elem, attrs) {
    return elem.click(function() {
      elem.siblings().removeClass("editing");
      elem.addClass("editing");
      return scope.editDataItem = scope.dataById(elem.data("_id"));
    });
  };
});
