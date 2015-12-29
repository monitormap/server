models = require('../models')
config = require('../../config')
rrd = require('../rrd')

update_node = (type,item) ->
	obj = {}
	console.log(type)
	for ds in models[type].DS
		for entry in Object.keys(item)
			if entry in ds
				obj[entry] = item[entry]
	console.log(obj)
	rrd.update(type,item.mac,obj)

_update_group = (type,items,name) ->
	obj = {}
	rrd.update(type,name,obj)

update_group = (type,items,macs,name='') ->
	if macs.length <= 0
		_update_group(type,items,'global')
	else
		filtered = []
		for item in items
			if item.mac in macs
				filtered.push(item)
		_update_group(type,filtered,name)



module.exports = ->
	for type in Object.keys(models)
		if type.indexOf('_') !=0 and models[type].DB
			models[type].DB.findAll({where:{updatedAt:{$gt: new Date(new Date() - config.times.toRRD)}}}).then((items)->
				for item in items
					update_node(type,item)
				update_group(type,items,[])
			)
