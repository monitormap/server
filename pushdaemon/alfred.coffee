io = require('socket.io-client')
spawn = require('child_process').spawn
config = require('./config')

options =
	transports: ['websocket']
	path: '/ws'
	'force new connection': true

alfred = (r,call)->
	prozess = spawn('alfred-json', ["-z","-s",config.socket_alfred,"-r",r])
	prozess.stdout.setEncoding('utf8')
	prozess.stderr.setEncoding('utf8')
	data =''
	err = false;
	prozess.stdout.on('data', (adata)->
		data=data+''+adata;
	)
	prozess.stderr.on('data', (data)->
		err = true;
	)
	prozess.on('exit', (exit)->
		if(!err && !exit)
			output = JSON.parse(data)
			call(output)
		else
			call([])
	)
getInfos = (call)->
	alfred('158',(nodeinfo)->
		alfred('159',(statistics)->
			output = []
			if nodeinfo
				for item in Object.keys(nodeinfo)
					output.push({nodeinfo:nodeinfo[item],statistics:(if statistics then statistics[item])})
			call(output)
		)
	)

socket = io.connect(config.url_socket,options)
getInfos((data)->
	if data and data.length>0
		c=data.length
		for item in data
			obj =
				name:item.nodeinfo.hostname,
				owner:(if item.nodeinfo.owner then item.nodeinfo.owner.contact),
				timedate: new Date(),
				mac:item.nodeinfo.network.mac,
				lat:(if item.nodeinfo.location then item.nodeinfo.location.latitude),
				lon:(if item.nodeinfo.location then item.nodeinfo.location.longitude),

				channel_24:6,
				channel_50:40,
				channel_24_power:11,
				channel_50_power:11,
				client_24:(if item.statistics.clients then item.statistics.clients.wifi),
				client_50:0,
				ports:(if item.statistics.clients then item.statistics.clients.total-item.statistics.clients.wifi),
				ports_gb:0,
				tx_bytes:item.statistics.traffic.tx.bytes,
				tx_packets:item.statistics.traffic.tx.packets,
				rx_bytes:item.statistics.traffic.rx.bytes,
				rx_packets:item.statistics.traffic.rx.packets,

				tx_24_bytes:item.statistics.traffic.tx.bytes,
				tx_24_packets:item.statistics.traffic.tx.packets,
				rx_24_bytes:item.statistics.traffic.rx.bytes,
				rx_24_packets:item.statistics.traffic.rx.packets,

				tx_50_bytes:0,
				tx_50_packets:0,
				rx_50_bytes:0,
				rx_50_packets:0
			socket.emit('node:set',config.passphrase,obj,(data)->
				c-=1
				if c <=0
					socket.disconnect()
			)
	else
		socket.disconnect()
)
