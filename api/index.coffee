app = require('express')()

models = require('../lib/models')


app.use('/ansible',require('./ansible'))

app.get('/statistic',(req,res)->
	models.Node.DB.findAll().then((nodes)->
		output =
			client_24: 0
			client_50: 0
		for i in nodes
			output.client_24 += i.client_24
			output.client_50 += i.client_50
		output.clients = output.client_24+output.client_50
		res.jsonp(output)
	)
)
module.exports = app
