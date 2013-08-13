var AppCtrl, DataCtrl, IndexCtrl,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

DataCtrl = (function() {
  function DataCtrl($scope, User, Datapoint) {
    var _this = this;
    this.$scope = $scope;
    this.User = User;
    this.Datapoint = Datapoint;
    this.refresh();
    this.$scope.insertData = function() {
      var field, postItem, _i, _len, _ref;
      postItem = {};
      _ref = _this.$scope.dataFields;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        field = _ref[_i];
        postItem[field] = _this.$scope[field];
      }
      _this.Datapoint.save(postItem);
      _this.$scope.editDataItem = null;
      return _this.$scope.data = _this.Datapoint.query();
    };
    this.$scope.$watch("users.length", function() {
      if ((_this.$scope.users.length != null) && (_this.$scope.users[0] != null) && (_this.$scope.users[0].email != null)) {
        _this.$scope.user = _this.$scope.users[0];
        return _this.$scope.data = _this.Datapoint.query();
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
                if (!(__indexOf.call(this.$scope.dataFields, field) >= 0 || field.match(/(^\$|_id|experiment|__v)/))) {
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
    this.$scope.getClass = function(id, field) {
      var elem;
      elem = angular.element("[data-id=" + id + "] [data-field=" + field + "]");
      if (isNaN(elem.text())) {
        return "fieldText";
      } else if (parseInt(elem.text(), 10) > 0) {
        return "fieldPositiveNumber";
      } else if (parseInt(elem.text(), 10) < 0) {
        return "fieldNegativeNumber";
      } else {
        return "fieldZero";
      }
    };
    this.$scope.getField = function(fieldIndex) {
      return _this.$scope.dataFields[fieldIndex];
    };
    this.$scope.populateForm = function() {
      var field, _results;
      _results = [];
      for (field in _this.$scope.data[_this.$scope.editDataItem]) {
        _results.push(_this.$scope[field] = _this.$scope.data[_this.$scope.editDataItem][_this.$scope.dataFields[index]]);
      }
      return _results;
    };
  }

  DataCtrl.prototype.refresh = function() {
    this.$scope.editDataItem = null;
    this.$scope.users = this.User.query();
    this.$scope.user = null;
    return this.$scope.data = [];
  };

  DataCtrl.inject = ["$scope", "User", "Datapoint"];

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

IndexCtrl = (function() {
  function IndexCtrl($scope, $http, User) {
    var _this = this;
    this.$scope = $scope;
    this.$http = $http;
    this.User = User;
    this.$scope.users = User.query();
    this.$scope.user = null;
    this.$scope.$watch("users.length", function() {
      if ((_this.$scope.users.length != null) && (_this.$scope.users[0] != null) && (_this.$scope.users[0].email != null)) {
        return _this.$scope.user = _this.$scope.users[0];
      }
    });
    this.$scope.signIn = function() {
      var postData;
      postData = {
        email: _this.$scope.email,
        password: _this.$scope.password
      };
      _this.$http.post("./login", postData).success(function(data) {
        return _this.$scope.users = User.query();
      });
      return angular.element("#signInForm").modal("hide");
    };
  }

  IndexCtrl.inject = ["$scope", "$http", "User", "$timeout"];

  return IndexCtrl;

})();
