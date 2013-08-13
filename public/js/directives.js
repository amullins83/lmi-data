var directives;

directives = angular.module("lmiData.directives", []);

directives.directive("autoColor", function() {
  return function(scope, elem, attrs) {
    var negColor, neutralColor, parse, posColor, textColor;
    textColor = attrs["textColor"] || "#ddd";
    posColor = attrs["posColor"] || "#8f8";
    negColor = attrs["negColor"] || "#f84";
    neutralColor = attrs["neutralColor"] || "#fff";
    parse = parseInt(elem.text(), 10);
    if (isNaN(parse)) {
      return elem.css({
        background: textColor
      });
    } else if (parse > 0) {
      return elem.css({
        background: posColor
      });
    } else if (parse < 0) {
      return elem.css({
        background: negColor
      });
    } else {
      return elem.css({
        background: neutralColor
      });
    }
  };
});

directives.directive("editOnClick", function() {
  return function(scope, elem, attrs) {
    return elem.click(function() {
      elem.siblings().removeClass("editing");
      elem.addClass("editing");
      return scope.editDataItem = scope.data[parseInt(elem.find(".col-lg-1:first-child").text(), 10)];
    });
  };
});
