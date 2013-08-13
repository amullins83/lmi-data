class DataCtrl
    constructor: (@$scope, @User, @Datapoint)->
        @refresh()

        @$scope.insertData = =>
            @Datapoint.create @$scope.editDataItem
            @$scope.editDataItem = {}
            @$scope.data = @Datapoint.query()

        @$scope.$watch "users.length", =>
            if @$scope.users.length? and @$scope.users[0]? and @$scope.users[0].email?
                @$scope.user = @$scope.users[0]
                @$scope.data = @Datapoint.query()

        @$scope.$watch "data.length", =>
            @$scope.dataFields = []
            if @$scope.data.length > 0
                for dataPoint in @$scope.data
                    if typeof dataPoint is "object"
                        for field of dataPoint
                            unless field in @$scope.dataFields or field.match /(^\$|_id|experiment)/ 
                                @$scope.dataFields.push field

        @$scope.dataById = (id)=>
            for item in @$scope.data
                return item if item._id is id
            return {}

        @$scope.getClass = (id, field)=>
            elem = angular.element "[data-id=#{id}] [data-field=#{field}]"

            if isNaN elem.text()
                return "fieldText"
            else if parseInt(elem.text(), 10) > 0
                return "fieldPositiveNumber"
            else if parseInt(elem.text(), 10) < 0
                return "fieldNegativeNumber"
            else
                return "fieldZero"

    refresh: ->
        @$scope.editDataItem = {}
        @$scope.users = @User.query()
        @$scope.user = null
        @$scope.data = []


    @inject: ["$scope", "User", "Datapoint"]


class AppCtrl
    constructor: (@$scope, @User)->

    @inject: ["$scope", "User"]


class SignInCtrl
    constructor: (@$scope, @$http, @User)->
        @$scope.users = User.query()
        @$scope.user = null

        @$scope.$watch "users.length", =>
            if @$scope.users.length? and @$scope.users[0]? and @$scope.users[0].email?
                @$scope.user = @$scope.users[0]    

        @$scope.signIn = =>
            postData =
                email: @$scope.email
                password: @$scope.password

            @$http.post("./login", postData).success (data)=>
                @$scope.users = User.query()
            angular.element("#signInForm").modal("hide")

    @inject: ["$scope", "$http", "User"]

class IndexCtrl
    constructor: (@$scope, @User, @$timeout)->
        @$scope.users = User.query()
        @$scope.user = null

        @$scope.$watch "users.length", =>
            if @$scope.users.length? and @$scope.users[0]? and @$scope.users[0].email?
                @$scope.user = @$scope.users[0]    

        @$scope.userUpdateInterval = 2000

        @$scope.userUpdate = =>
            @$timeout.cancel @$scope.to
            @$scope.to = @$timeout =>
                @$scope.users = User.query()
                @$scope.userUpdate()
            , @$scope.userUpdateInterval

        @$scope.userUpdate()

    @inject: ["$scope", "User", "$timeout"]
