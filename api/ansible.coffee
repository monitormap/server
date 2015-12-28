app = require('express')()

models = require('../lib/models')

app.get('/fetch',(req,res)->
	res.jsonp({s:false})
)

app.get('/get',(req,res)->
	models.Node.DB.findAll({}).then((nodes)->
		output =
			nodes:[],
			_meta:
				hostvars : {}
		for node in nodes
			if(node.status)
				name = node.mac.replace(/[:-]/g,"")
				mac	= node.mac.replace(/:/g,"-").split("-")

				output.nodes.push(name);

				output._meta.hostvars[name] =
					ansible_ssh_host: ipv6calc.toIPv6(config.scanner.ipv6_prefix, mac.join(':')),
					node_name: node.name,
					radio24_channel: node.channel_24,
					radio24_txpower: node.channel_24_power,
					radio5_channel: node.channel_50,
					radio5_txpower: node.channel_50_power,
					geo_latitude: node.lat,
					geo_longitude: node.lon
		res.jsonp(output)
	)
)

module.exports = app
