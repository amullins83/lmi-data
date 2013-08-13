var AppCtrl, DataCtrl, IndexCtrl, SignInCtrl,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

DataCtrl = (function() {
  function DataCtrl($scope, User, Datapoint) {
    var _this = this;
    this.$scope = $scope;
    this.User = User;
    this.Datapoint = Datapoint;
    this.refresh();
    this.$scope.insertData = function() {
      _this.Datapoint.create(_this.$scope.editDataItem);
      _this.$scope.editDataItem = {};
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
                if (!(__indexOf.call(this.$scope.dataFields, field) >= 0 || field.match(/(^\$|_id|experiment)/))) {
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
    this.$scope.dataById = function(id) {
      var item, _i, _len, _ref;
      _ref = _this.$scope.data;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        if (item._id === id) {
          return item;
        }
      }
      return {};
    };
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
  }

  DataCtrl.prototype.refresh = function() {
    this.$scope.editDataItem = {};
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

SignInCtrl = (function() {
  function SignInCtrl($scope, $http, User) {
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

  SignInCtrl.inject = ["$scope", "$http", "User"];

  return SignInCtrl;

})();

IndexCtrl = (function() {
  function IndexCtrl($scope, User, $timeout) {
    var _this = this;
    this.$scope = $scope;
    this.User = User;
    this.$timeout = $timeout;
    this.$scope.users = User.query();
    this.$scope.user = null;
    this.$scope.$watch("users.length", function() {
      if ((_this.$scope.users.length != null) && (_this.$scope.users[0] != null) && (_this.$scope.users[0].email != null)) {
        return _this.$scope.user = _this.$scope.users[0];
      }
    });
    this.$scope.userUpdateInterval = 2000;
    this.$scope.userUpdate = function() {
      _this.$timeout.cancel(_this.$scope.to);
      return _this.$scope.to = _this.$timeout(function() {
        _this.$scope.users = User.query();
        return _this.$scope.userUpdate();
      }, _this.$scope.userUpdateInterval);
    };
    this.$scope.userUpdate();
  }

  IndexCtrl.inject = ["$scope", "User", "$timeout"];

  return IndexCtrl;

})();
