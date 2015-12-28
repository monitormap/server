config = require('../config')

log = require('../lib/log')
models = require('../lib/models')

module.exports = (io,socket)->
	require('./node')(io,socket)
