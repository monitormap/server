io = require('socket.io-client')

options =
	transports: ['websocket']
	path: '/ws'
	'force new connection': true

socket = io.connect('http://localhost:8080',options)
console.log('Init')
obj =
	name:"TEST-Dummy",
	owner:"none",
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
	traffic_tx_bytes:0,
	traffic_tx_packets:0,
	traffic_rx_bytes:0,
	traffic_rx_packets:0,

	traffic_tx_24_bytes:0,
	traffic_tx_24_packets:0,
	traffic_rx_24_bytes:0,
	traffic_rx_24_packets:0,

	traffic_tx_50_bytes:0,
	traffic_tx_50_packets:0,
	traffic_rx_50_bytes:0,
	traffic_rx_50_packets:0
console.log(obj)
socket.emit('node:set','test',obj,(data)->
	console.log("Recieved:",data)
	socket.disconnect()
)
console.log("End")
