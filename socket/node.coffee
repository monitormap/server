config = require('../config')

log = require('../lib/log')
models = require('../lib/models')

module.exports = (socket)->
	socket.on('node:list',(call)->
		models.Node.DB.findAll().then((node)->
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

	socket.on('node:group:set',(passphrase,new_group,call)->
		if(passphrase==config.passphrase)
			models.Node.Group.findAll({where:{mac:new_group.name}}).then((group)->
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
