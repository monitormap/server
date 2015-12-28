models = require('../models')
config = require('../../config')
RRD = require('../rrdtool')

update = (item) ->
	console.log(item.mac)



module.exports = ->
	for type in Object.keys(models)
		if type.indexOf('_') != 0 and models[type].DB
			models[type].DB.findAll({where:{updatedAt:{$gt: new Date(new Date() - config.times.nottoRRD)}}}).then((items)->
				for item in items
					update(item)
			)
