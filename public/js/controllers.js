var AppCtrl, DataCtrl,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

DataCtrl = (function() {
  function DataCtrl($scope, Datapoint) {
    var _this = this;
    this.$scope = $scope;
    this.Datapoint = Datapoint;
    this.$scope.editDataItem = {};
    this.$scope.data = this.Datapoint.query();
    this.$scope.$watch("data.length", function() {
      var dataPoint, field, _i, _len, _ref, _results;
      _this.$scope.dataFields = [];
      if (_this.$scope.data.length > 0) {
        _ref = _this.$scope.data;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          dataPoint = _ref[_i];
          _results.push((function() {
            var _results1;
            _results1 = [];
            for (field in dataPoint) {
              if (!(__indexOf.call(this.$scope.dataFields, field) >= 0 || field.match(/^\$/))) {
                _results1.push(this.$scope.dataFields.push(field));
              } else {
                _results1.push(void 0);
              }
            }
            return _results1;
          }).call(_this));
        }
        return _results;
      }
    });
  }

  DataCtrl.inject = ["$scope", "Datapoint"];

  return DataCtrl;

})();

AppCtrl = (function() {
  function AppCtrl($scope) {
    this.$scope = $scope;
  }

  return AppCtrl;

})();
