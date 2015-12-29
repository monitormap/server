models = require('../models')
config = require('../../config')
rrd = require('../rrd')

update_node = (type,item) ->
	obj = {}
	for ds in models[type].DS
		for entry in Object.keys(item.dataValues)
			if ds.indexOf(entry) >= 0
				obj[entry] = item[entry]
	rrd.update(type,item.mac,obj)

_update_group = (type,items,name) ->
	obj = {}
	if items.length >0
		for ds in models[type].global.DS
			for entry in Object.keys(items[0].dataValues)
				if ds.indexOf(entry) >= 0
					for item in items
						if obj[entry]
							obj[entry] += item[entry]
						else
							obj[entry] = item[entry]
	console.log(name,obj)
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
		if type.indexOf('_') != 0
			# findAll async fix
			t = type+''
			models[type].DB.findAll({where:{updatedAt:{$gt: new Date(new Date() - config.times.toRRD)}}}).then((items)->
				for item in items
					update_node(t,item)
				models[t].Group.findAll().then((groups)->
					for item in groups
						update_group(t,items,item.macs,item.name)
				)
				update_group(t,items,[])
			)
