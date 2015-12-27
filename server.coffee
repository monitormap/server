express = require('express')
app = express()
server = require('http').Server(app)
io = require('socket.io').listen(server,{path:'/ws'})

config = require('./config')
log = require('./lib/log')

if(config.dynamisch)
	app.use(express.static('static_src'))
	app.set('view engine', 'jade')
	app.get('/', (req,res)->
		res.render('index')
		log("debug",req,"website")
	)
else
	app.use(express.static('static'))

socket = require('./socket')
io.sockets.on('connection',socket)

api = require('./api')
app.use('/api',api)

server = app.listen(config.port,config.ip, ->

	host = server.address().address
	port = server.address().port

	log("debug",null,"init server on: "+host+":"+port)
)
