class DataCtrl
    constructor: (@$scope, @Data)->
        @$scope.editDataItem = {}
        @$scope.data = @Data.query()
        @$scope.$watch "data.length", =>
            @$scope.dataFields = []
            if @$scope.data.length > 0
                unless @$scope.editDataItem.number?
                    @$scope.editDataItem = @$scope.data[0]
                for dataPoint in @$scope.data
                    for field of dataPoint
                        unless field in @$scope.dataFields or field.match /^\$/
                            @$scope.dataFields.push field

    @inject: ["$scope", "Data"]


class AppCtrl
    constructor: (@$scope)->
