# data in json format
models = require "../models"

renderJSON = (res)->
    (err, objects)->
        if(err)
            res.json err
        else
            res.json objects


pluralize = (word)->
    return word + 's' unless word[word.length - 1].toLowerCase() in ['s', 'x', 'y']
    return word[..-2] + 'ies' if word[word.length -1] == 'y'
    return word + 'es'


class Resource
    constructor: (name, @filterFunction, @sortFunction)->
        @name = name.toLowerCase()
        @Name = @name[0].toUpperCase() + @name[1..]
        @Model = models[@Name]
        @name = pluralize @name

    noUserError: (res)->
        res.json
            message: "Error: No user logged in."

    get: (req, res)->
        filter = @filterFunction(req)
        sort = @sortFunction()
        if req.user?
            findObject = {}
            if req.params.id?
                findObject._id = req.params.id
                for key of filter
                    findObject[key] = filter[key]
                return Model.findOne(findObject).exec renderJSON(res)
            if req.query?
                findObject = req.query
            for key of filter
                findObject[key] = filter[key]
            Model.find(findObject).sort(sort).exec renderJSON(res)
        else
            @noUserError(res)

    create: (req, res)->
        if req.user?
            Model.create req.body, renderJSON(res)
        else
            @noUserError(res)

    edit:  (req, res)->
        unless req.user?
            return @noUserError(res)
        filter = @filterFunction(req)
        findObject = {}
        if req.params.id?
            for key of filter
                findObject[key] = filter[key]
            findObject._id = req.params.id
            return Model.findOneAndUpdate(findObject, req.body.updateObject).exec renderJSON(res)
            
        for key of filter
            findObject[key] = filter[key]
        for key of req.body.findObject
            findObject[key] = req.body.findObject[key]
        Model.findOneAndUpdate findObject, req.body.updateObject, renderJSON(res)
            
    destroy: (req, res)->
        unless req.user?
            return @noUserError(res)
        filter = filterFunction(req)
        findObject = {}
        for key of filter
            findObject[key] = filter[key]
        if req.params.id?
            findObject._id = req.params.id
            return Model.remove findObject, renderJSON(res)
        for key of filter
            findObject[key] = filter[key]
        for key of req.body
            findObject[key] = req.body[key]
        Model.remove findObject, renderJSON(res)

    count: (req, res)->
        unless req.user?
            return @noUserError(res)
        filter = filterFunction(req)
        findObject = {}
        for key of filter
            findObject[key] = filter[key]
        Model.count findObject, renderJSON(res)

    resourceForApp: (app)->
        app.get "/api/#{@name}/:id", @get
        app.get "/api/#{@name}", @get
        app.put "/api/#{@name}/:id", @edit
        app.post "/api/#{@name}", @create
        app.delete "/api/#{@name}/:id", @destroy


exports.datapoints = new Resource "Datapoint", (req)->
    findObject = {}
    findObject.experiment = req.experiment if req.experiment?
    return findObject
, ->
    return "datetime"


exports.experiments = new Resource "Experiment", (req)->
    findObject = {}
    findObject.products = $all: [req.product] if req.product?
    return findObject
, ->
    return "datetime"


exports.products = new Resource "Product", (req)->
    return {}
, ->
    return "datetime"


exports.specs = new Resource "Spec", (req)->
    findObject = {}
    findObject.product = req.product if req.product?
    return findObject
, ->
    return "datetime"


exports.users = new Resource "User", (req)->
    return {}
, ->
    return "userName"

exports.resources = resources = []
for element of exports
    resources.push element if element.constructor is Resource
