# GET home page.
 
exports.index = (req, res)->
    assetURLPrefix = "https://s3.amazonaws.com/lmi-mullins/assets/application"
    res.render 'index', title: 'LMI Data', styleURL:assetURLPrefix + ".css", scriptURL:assetURLPrefix + ".js"

exports.partials = (req, res)->
    if req.params.page?
        res.render 'views/partials/#{req.params.page}'
    else
        res.end()
