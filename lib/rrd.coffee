config = require('../config')
RRD = require('./rrdtool')
fs = require('fs')

createParam = ['-s',''+((config.times.stepRRD/1000)|0)]

rrd_cache = {}

create = (name,type)->
	if(!fs.existsSync(config.rrd_path))
		fs.mkdirSync(config.rrd_path)
		if(!fs.existsSync(config.rrd_path+'/'+name))
			fs.mkdirSync(config.rrd_path+'/'+name)

	type.DB.findAll().then((list)->
		for item in list
			path = config.rrd_path+'/'+name+'/'+item.mac+'.rrd'
			try
				fs.statSync(path);
			catch
				tmp = new RRD()
				tmp.create(path,createParam,type.DS,type.RRA,(err)->)
				rrd_cache[path] = tmp
	)
	type.Group.findAll().then((list)->
		for item in list
			path = config.rrd_path+'/'+name+'/'+item.name+'.rrd'
			try
				fs.statSync(path);
			catch
				tmp = new RRD()
				tmp.create(path,createParam,type.global.DS,type.global.RRA,(err)->)
				rrd_cache[path] = tmp
	)
	if type.global
		path = config.rrd_path+'/'+name+'/global.rrd'
		try
			fs.statSync(path);
		catch
			tmp = new RRD()
			tmp.create(path,createParam,type.global.DS,type.global.RRA,(err)->)
			rrd_cache[path] = tmp

update = (type,name,data)->
	if data and Object.keys(data).length >0
		time = 'N'
		type = type.toLowerCase()
		path = config.rrd_path+'/'+type+'/'+name+'.rrd'
		if not rrd_cache[path]
			models = require('./models')
			typename = type.charAt(0).toUpperCase() + type.slice(1)
			create(type,models[typename])
			tmp = new RRD()
			tmp.update(path,time,data,(err)->)
		else
			rrd_cache[path].update(path,time,data,(err)->)


module.exports.create = create
module.exports.update = update
