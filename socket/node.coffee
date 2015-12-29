config = require('../config')

log = require('../lib/log')
models = require('../lib/models')
rrd = require('../lib/rrd')

module.exports = (io,socket)->
	socket.on('node:list',(call)->
		models.Node.DB.findAll().then((node)->
			if node.length>0
				call({s:true,list:node})
			else
				call({s:false})
		)
	)
	socket.on('node:list:new',(call)->
		models.Node.DB.findAll({where:{createdAt:{$gt: new Date(new Date() - config.newitems)}}}).then((node)->
			if node.length>0
				call({s:true,list:node})
			else
				call({s:false})
		)
	)
	socket.on('node:set',(passphrase,new_node,call)->
		if(passphrase==config.passphrase)
			models.Node.DB.findAll({where:{mac:new_node.mac}}).then((node)->
				if node.length <= 0
					models.Node.DB.create(new_node).then((node)->
						io.emit('event::node:set:create',node)
						rrd.create('node',models.Node)
						call({s:(if node then true else false)})
					)
				else
					models.Node.DB.update(new_node, {where: {mac: new_node.mac}}).then((node)->
						call({s:(if node then true else false)})
					)
			)
		else
			call({s:false})
	)
	socket.on('node:group:list',(call)->
		models.Node.Group.findAll().then((groups)->
			if groups.length>0
				call({s:true,list:groups})
			else
				call({s:false})
		)
	)
	socket.on('node:group:set',(passphrase,new_group,call)->
		if(passphrase==config.passphrase)
			models.Node.Group.findAll({where:{name:new_group.name}}).then((group)->
				if group.length <= 0
					models.Node.Group.create(new_group).then((group)->
						call({s:(if group then true else false)})
					)
				else
					models.Node.Group.update(new_group, {where: {name: new_group.name}}).then((group)->
						call({s:(if group then true else false)})
					)
			)
		else
			call({s:false})
	)
