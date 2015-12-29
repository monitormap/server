models = require('../models')
config = require('../../config')
rrdtool = require('../rrd')
RRD = require('../rrdtool')

update_node = (item) ->
	console.log(item.mac)

update_group = (items,macs) ->



module.exports = ->
	for type in Object.keys(models)
		if type.indexOf('_') != 0 and models[type].DB
			models[type].DB.findAll({where:{updatedAt:{$gt: new Date(new Date() - config.times.toRRD)}}}).then((items)->
				for item in items
					update_node(item)
				update_group(items,[])
			)
