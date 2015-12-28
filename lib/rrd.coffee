models = require('./models')
config = require('../config')
RRD = require('./rrdtool')
fs = require('fs')

createParam = ['-s','360']


create = (name,type)->
	if(!fs.existsSync(config.rrd_path))
		fs.mkdirSync(config.rrd_path)
		if(!fs.existsSync(config.rrd_path+'/'+name))
			fs.mkdirSync(config.rrd_path+'/'+name)

	type.DB.findAll().then((list)->
		for item in list
			tmp = new RRD()
			tmp.create(config.rrd_path+'/'+name+'/'+item.mac+'.rrd',createParam,type.DS,type.RRA,(err)->
			)
	)
	type.Group.findAll().then((list)->
		for item in list
			tmp = new RRD()
			tmp.create(config.rrd_path+'/'+name+'/'+item.name+'.rrd',createParam,type.global.DS,type.global.RRA,(err)->
			)
	)
	if type.global
		tmp = new RRD()
		tmp.create(config.rrd_path+'/'+name+'/global.rrd',createParam,type.global.DS,type.global.RRA,(err)->
		)

module.exports.create = create
