# data in json format
fs = require "fs"

exports.data = (req, res)->
    fs.readFile "data/M3D_LCD_Currents_AMM_08_09_2013.json", (err, data)->
        dataObject = JSON.parse data.toString()
        list = dataObject.dataPoints
        unless req.params.id?
            res.json list
        else
            res.json list[id]

exports.users = (req, res)->
    res.json message: "Not yet implemented", users: []
