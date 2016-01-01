app = require('express')()
config = require('../config')
models = require('../lib/models')


app.use('/ansible',require('./ansible'))


statistic = (nodes)->
	output =
		client_24: 0
		client_50: 0
		nodes: (if nodes then nodes.length)
	for i in nodes
		output.client_24 += i.client_24
		output.client_50 += i.client_50
	output.clients = output.client_24+output.client_50
	return output

app.get('/statistic',(req,res)->
	models.Node.DB.findAll({where:{updatedAt:{$gt: (new Date(new Date().getTime() - config.times.statistic)).getTime()}}}).then((nodes)->
		res.jsonp(statistic(nodes))
	)
)
app.get('/statistic/:name',(req,res)->
	models.Node.Group.findAll({where:{name:req.param.name}}).then((group)->
		models.Node.DB.findAll({where:{mac:group.nodes,updatedAt:{$gt: (new Date(new Date().getTime() - config.times.statistic)).getTime()}}}).then((nodes)->
			res.jsonp(statistic(nodes))
		)
	)
)
module.exports = app
