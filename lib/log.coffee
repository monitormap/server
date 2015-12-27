colors = require('colors')
fs = require('fs')

config = require('../config').log

module.exports = (type='debug',req=null,text)->
	#console.log('['+type+'] '+socket.conn.remoteAddress+' '+text)
	show = false
	write = false

	atype = '['+type+'] '
	switch(type)
		when 'debug'
			if config.write in ['debug']
				write = true
			if config.show in ['debug']
				show = true
			atype = atype
		when 'info'
			if config.write in ['debug','info']
				write = true
			if config.show in ['debug','info']
				show = true
			atype = atype.green
		when 'warn'
			if config.write in ['debug','info','warn']
				write = true
			if config.show in ['debug','info','warn']
				show = true
			atype = atype.yellow
		when 'error'
			write = true
			show = true
			atype = atype.red

	output = (new Date().toJSON())+' '+atype+
	 ((if req and req.ip then req.ip else "none" )+' ').gray+
	 ((if req and req.session then req.session.id else "none" )+'').gray+
	 (if req and req.originalUrl then ' '+req.originalUrl else '').blue+
	 (if text then ' '+text else '')

	if(show)
		console.log(output)


	if(write)
		fs.appendFile(config.write_file, output+'\n')
