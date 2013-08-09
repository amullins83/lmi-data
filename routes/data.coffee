# data in json format
fs = require "fs"

exports.list = (req, res)->
	fs.readFile "data/M3D_LCD_Currents_AMM_08_09_2013.json", (err, data)->
		res.json data.toString()
