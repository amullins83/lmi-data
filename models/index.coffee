mongoose = require "mongoose"
bcrypt = require "bcrypt"
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

exports.userObject = userObject =
    firstName: type: String
    lastName: type: String
    displayName: type: String
    userName: type: String
    email: type: String, required: true, index: unique: true
    password: type: String, required: true
    creationDate: type: Date, index: true
    lastLogin: type: Date, default: new Date
    socialMediaPersonae: [{type: mongoose.Schema.ObjectId, ref: "SocialMediaUser"}]

userSchema = mongoose.Schema userObject

userSchema.pre "save", (next)->
    unless @isModified 'password'
        return next()

    bcrypt.genSalt parseInt(process.env.SALT_WORK_FACTOR, 10), (err, salt)=>
        if err
            return next err

        bcrypt.hash @password, salt, (err, hash)=>
            if err
                return next err
            @password = hash
            @salt = salt
            next()

userSchema.methods.comparePassword = (candidatePassword, cb)->
    bcrypt.compare candidatePassword, @password, (err, isMatch)->
        if err
            console.dir err
            return cb err
        cb null, isMatch


User = exports.User = mongoose.model "User", userSchema


exports.socialMediaUserObject = socialMediaUserObject = 
    providerName: type: String, required: true
    providerUserId: type: String, required: true
    displayName: type: String, required: true
    user: type: mongoose.Schema.ObjectId, ref: "User"

socialMediaUserSchema = exports.socialMediaUserSchema = mongoose.Schema socialMediaUserObject
exports.SocialMediaUser = SocialMediaUser = mongoose.model "SocialMediaUser", socialMediaUserSchema

exports.ready = (callback)->
    db.once "open", callback
