io = require('socket.io-client')
config = require('./config')

options =
	transports: ['websocket']
	path: '/ws'
	'force new connection': true

socket = io.connect(config.url_socket,options)
console.log('Init')
obj =
	name:"TEST-Dummy",
	owner:"none",
	timedate: new Date(),
	mac:"f1:f1:f1:f1:f1:f1",
	lat:5.443432,
	lon:53.443432,

	channel_24:6,
	channel_50:40,
	channel_24_power:11,
	channel_50_power:11,
	client_24:0,
	client_50:0,
	ports:0,
	ports_gb:0,
	tx_bytes:0,
	tx_packets:0,
	rx_bytes:0,
	rx_packets:0,

	tx_24_bytes:0,
	tx_24_packets:0,
	rx_24_bytes:0,
	rx_24_packets:0,

	tx_50_bytes:0,
	tx_50_packets:0,
	rx_50_bytes:0,
	rx_50_packets:0
console.log(obj)
socket.emit('node:set',config.passphrase,obj,(data)->
	console.log("Recieved:",data)
	socket.disconnect()
)
console.log("End")
