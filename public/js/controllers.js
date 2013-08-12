var AppCtrl, DataCtrl,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

DataCtrl = (function() {
  function DataCtrl($scope, User, Data) {
    var _this = this;
    this.$scope = $scope;
    this.User = User;
    this.Data = Data;
    this.$scope.editDataItem = {};
    this.$scope.users = this.User.query();
    this.$scope.user = null;
    this.$scope.data = [];
    this.$scope.$watch("users.length", function() {
      if (_this.$scope.users.length != null) {
        _this.$scope.user = _this.$scope.users[0];
        return _this.$scope.data = _this.Data.query();
      }
    });
    this.$scope.$watch("data.length", function() {
      var dataPoint, field, _i, _len, _ref, _results;
      _this.$scope.dataFields = [];
      if (_this.$scope.data.length > 0) {
        _ref = _this.$scope.data;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          dataPoint = _ref[_i];
          if (typeof dataPoint === "object") {
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
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      }
    });
    this.$scope.insertData = function() {
      _this.Data.create(_this.$scope.editDataItem);
      _this.$scope.editDataItem = {};
      return _this.$scope.data = _this.Data.query();
    };
  }

  DataCtrl.inject = ["$scope", "User", "Data"];

  return DataCtrl;

})();

AppCtrl = (function() {
  function AppCtrl($scope, User) {
    this.$scope = $scope;
    this.User = User;
  }

  AppCtrl.inject = ["$scope", "User"];

  return AppCtrl;

})();
