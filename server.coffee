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

if(config.dynamisch)
	app.use(express.static('static_src'))
	app.set('view engine', 'jade')
	partials = (req, res)->
	  filename = req.params.filename
	  return unless filename
	  res.render "app/#{filename}.jade"
	app.get('/app/:filename.html', partials)
	app.get('/', (req,res)->
		res.render('index')
		log("debug",req,"website")
	)
else
	app.use(express.static('static'))


server = require('http').Server(app)
io = require('socket.io')(server,{path:'/ws'})

socket = require('./socket')
io.sockets.on('connection',socket)

server.listen(config.port,config.ip, ->
	log("debug",null,"init server on: "+config.ip+":"+config.port)
)
