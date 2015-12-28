app = require('express')()

config = require('../config')

log = require('../lib/log')
models = require('../lib/models')

module.exports = (socket)->
	socket.on('node:list',(call)->
		models.Node.findAll({
		include:
			- model:models.Node,as:'parent'
		}).then((node)->
			if node.length>0
				call({s:true,list:node})
			else
				call({s:false})
		)
	)
