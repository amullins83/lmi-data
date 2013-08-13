mongoose = require "mongoose"

mongoose.connect process.env.MONGOLAB_URI
exports.db = db = mongoose.connection

productObject =
    name: String
    type: String
    series: String
    specs: mongoose.Schema.Types.ObjectId
    datetime: Date

specObject =
    product: mongoose.Schema.Types.ObjectId
    absoluteMaximumRatings: mongoose.Schema.Types.Mixed
    characteristics: mongoose.Schema.Types.Mixed
    datetime: Date

experimentObject =
    products: [
        mongoose.Schema.Types.ObjectId
    ]
    name: String
    summary: String
    datetime: Date

datapointObject =
    experiment: mongoose.Schema.Types.ObjectId
    datetime: Date

exports.Product = Product = mongoose.model "Product", mongoose.Schema productObject

exports.Spec = Spec = mongoose.model "Spec", mongoose.Schema specObject

exports.Experiment = Experiment = mongoose.model "Experiment", mongoose.Schema experimentObject

exports.Datapoint = Datapoint = mongoose.model "Datapoint", mongoose.Schema datapointObject

exports.ready = (callback)->
    db.once "open", callback
