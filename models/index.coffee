mongoose = require "mongoose"

mongoose.connect process.env.MONGOLAB_URI
exports.db = db = mongoose.connection

Model = mongoose.Model
Schema = mongoose.Schema

productObject =
    name: String
    type: String
    series: String
    specs: Schema.ObjectId
    datetime: Date

specObject =
    product: Schema.ObjectId
    absoluteMaximumRatings: Schema.Mixed
    characteristics: Schema.Mixed
    datetime: Date

experimentObject =
    products: [
        Schema.ObjectId
    ]
    name: String
    summary: String
    datetime: Date

datapointObject =
    experiment: Schema.ObjectId
    datetime: Date

exports.Product = Product = Model Schema productObject

exports.Spec = Spec = Model Schema specObject

exports.Experiment = Experiment = Model Schema experimentObject

exports.Datapoint = Datapoint = Model Schema datapointObject

exports.ready = (callback)->
    db.once "open", callback
