models = require('./models')
config = require('../config')
RRD = require('./rrdtool')
fs = require('fs')

createParam = ['-s',''+(config.times.toRRD/1000)]

rrd_cache = {}

create = (name,type)->
	if(!fs.existsSync(config.rrd_path))
		fs.mkdirSync(config.rrd_path)
		if(!fs.existsSync(config.rrd_path+'/'+name))
			fs.mkdirSync(config.rrd_path+'/'+name)

	type.DB.findAll().then((list)->
		for item in list
			path = config.rrd_path+'/'+name+'/'+item.mac+'.rrd'
			tmp = new RRD()
			tmp.create(path,createParam,type.DS,type.RRA,(err)->)
			rrd_cache[path] = tmp
	)
	type.Group.findAll().then((list)->
		for item in list
			path = config.rrd_path+'/'+name+'/'+item.name+'.rrd'
			tmp = new RRD()
			tmp.create(path,createParam,type.global.DS,type.global.RRA,(err)->)
			rrd_cache[path] = tmp
	)
	if type.global
		path = config.rrd_path+'/'+name+'/global.rrd'
		tmp = new RRD()
		tmp.create(path,createParam,type.global.DS,type.global.RRA,(err)->)
		rrd_cache[path] = tmp

update = (type,name,data)->
	path = config.rrd_path+'/'+type+'/'+name+'.rrd'
	if rrd_cache[path]
		rrd_cache[path].update(path,'N',data,(err)->)

module.exports.create = create
module.exports.update = update
