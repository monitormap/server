express = require('express')
app = express()


config = require('./config')
log = require('./lib/log')

###
app.use((req, res, next) ->
	res.header("Access-Control-Allow-Origin", config.DOMAIN)
	res.header("Access-Control-Allow-Methods", "GET,POST")
	res.header("Access-Control-Allow-Credentials", "true")
	res.header("Access-Control-Allow-Headers", "X-Requested-With, Content-Type")
	next()
)
###


api = require('./api')
app.use('/api',api)

server = require('http').Server(app)
io = require('socket.io')(server,{path:'/ws'})

require('./lib/cronjob').init()

socket = require('./socket')
io.sockets.on('connection',(s)->
	socket(io,s)
)

server.listen(config.port,config.ip, ->
	log("debug",null,"init server on: "+config.ip+":"+config.port)
)
