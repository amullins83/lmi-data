class DataCtrl
    constructor: (@$scope, @User, @Datapoint)->
        @refresh()

        @$scope.insertData = =>
            postItem = {}
            for field in @$scope.dataFields
                postItem[field] = @$scope[field]
            @Datapoint.save postItem
            @$scope.editDataItem = null
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
                            unless field in @$scope.dataFields or field.match /(^\$|_id|experiment|__v)/ 
                                @$scope.dataFields.push field

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

        @$scope.getField = (fieldIndex)=>
            return @$scope.dataFields[fieldIndex]

        @$scope.populateForm = =>
            for field of @$scope.data[@$scope.editDataItem]
                @$scope[field] = @$scope.data[@$scope.editDataItem][@$scope.dataFields[index]]

    refresh: ->
        @$scope.editDataItem = null
        @$scope.users = @User.query()
        @$scope.user = null
        @$scope.data = []


    @inject: ["$scope", "User", "Datapoint"]


class AppCtrl
    constructor: (@$scope, @User)->

    @inject: ["$scope", "User"]


class IndexCtrl
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

    @inject: ["$scope", "$http", "User", "$timeout"]
