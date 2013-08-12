class DataCtrl
    constructor: (@$scope, @User, @Data)->
        @refresh()

        @$scope.insertData = =>
            @Data.create @$scope.editDataItem
            @$scope.editDataItem = {}
            @$scope.data = @Data.query()

        @$scope.$watch "users.length", =>
            if @$scope.users.length?
                @$scope.user = @$scope.users[0]
                @$scope.data = @Data.query()
        
        @$scope.$watch "data.length", =>
            @$scope.dataFields = []
            if @$scope.data.length > 0
                for dataPoint in @$scope.data
                    if typeof dataPoint is "object"
                        for field of dataPoint
                            unless field in @$scope.dataFields or field.match /^\$/
                                @$scope.dataFields.push field

    refresh: =>
        @$scope.editDataItem = {}
        @$scope.users = @User.query()
        @$scope.user = null
        @$scope.data = []


    @inject: ["$scope", "User", "Data"]


class AppCtrl
    constructor: (@$scope, @User)->

    @inject: ["$scope", "User"]


class SignInCtrl
    constructor: (@$scope, @$http, @User)->
        @$scope.users = User.query()
        @$scope.user = null

        @$scope.$watch "users.length", =>
            if @$scope.users.length?
                @$scope.user = @$scope.users[0]    

        @$scope.signIn = =>
            @$http.post("./login", postData).success (data)=>
                @$scope.users = User.query()

    @inject: ["$scope", "$http", "User"]