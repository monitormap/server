app = require('express')()
ipv6calc = require('ipv6calc')

config = require('../config')

models = require('../lib/models')

app.get('/fetch',(req,res)->
	res.jsonp({s:false})
)

get = (nodes)->
	output =
		nodes:[],
		_meta:
			hostvars : {}
	for node in nodes
		name = node.mac.replace(/[:-]/g,"")
		mac	= node.mac.replace(/:/g,"-").split("-")

		output.nodes.push(name);

		output._meta.hostvars[name] =
			ansible_ssh_host: ipv6calc.toIPv6(config.ipv6_prefix, mac.join(':')),
			node_name: node.name,
			radio24_channel: node.channel_24,
			radio24_txpower: node.channel_24_power,
			radio5_channel: node.channel_50,
			radio5_txpower: node.channel_50_power,
			geo_latitude: node.lat,
			geo_longitude: node.lon
	return output

app.get('/get',(req,res)->
	models.Node.DB.findAll({where:{updatedAt:{$gt: (new Date(new Date().getTime() - config.times.ansible)).getTime()}}}).then((nodes)->
		res.jsonp(get(nodes))
	)
)

app.get('/get/:name',(req,res)->
	models.Node.Group.findAll({where:{name:{$in:req.param.name}}}).then((group)->
		models.Node.DB.findAll({where:{mac:group.nodes,updatedAt:{$gt: (new Date(new Date().getTime() - config.times.ansible)).getTime()}}}).then((nodes)->
			res.jsonp(get(nodes))
		)
	)
)

module.exports = app
