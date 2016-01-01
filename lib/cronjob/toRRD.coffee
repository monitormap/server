models = require('../models')
config = require('../../config')
rrd = require('../rrd')

update_node = (type,item) ->
	obj = {}
	for ds in models[type].DS
		for entry in Object.keys(item.dataValues)
			if ds.indexOf(entry) >= 0
				obj[entry] = parseInt(item[entry])
	rrd.update(type,item.mac,obj)

_update_group = (type,items,name) ->
	obj = {}
	if items and items.length > 0
		obj.count = items.length
		for item in items
			for entry in Object.keys(item.dataValues)
				for ds in models[type].global.DS
					if ds.indexOf(entry) >= 0
						if obj[entry]
							obj[entry] += parseInt(item[entry])
						else
							obj[entry] = parseInt(item[entry])
	rrd.update(type,name,obj)

update_group = (type,items,macs,name='') ->
	if macs and macs.length <= 0
		_update_group(type,items,'global')
	else
		filtered = []
		for item in items
			if macs and item.mac in macs
				filtered.push(item)
		_update_group(type,filtered,name)



module.exports = ->
	for type in Object.keys(models)
		if type.indexOf('_') != 0
			# findAll async fix
			t = type+''
			models[type].DB.findAll({where:{updatedAt:{gt: (new Date(new Date().getTime() - config.times.toRRD)).getTime()}}}).then((items)->
				for item in items
					update_node(t,item)
				models[t].Group.findAll().then((groups)->
					for item in groups
						update_group(t,items,item.nodes,item.name)
				)
				update_group(t,items,[])
			)
