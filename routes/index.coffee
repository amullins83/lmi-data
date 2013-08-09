# GET home page.
 
exports.index = (req, res)->
  res.render 'index', title: 'LMI Data', styleURL:"https://s3.amazonaws.com/lmi-mullins/assets/application.css"
