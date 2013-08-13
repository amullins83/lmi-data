class DataCtrl
    constructor: (@$scope, @Datapoint)->
        @$scope.editDataItem = {}
        @$scope.data = @Datapoint.query()
        @$scope.$watch "data.length", =>
            @$scope.dataFields = []
            if @$scope.data.length > 0
                for dataPoint in @$scope.data
                    for field of dataPoint
                        unless field in @$scope.dataFields or field.match /^\$/
                            @$scope.dataFields.push field

    @inject: ["$scope", "Datapoint"]


class AppCtrl
    constructor: (@$scope)->
