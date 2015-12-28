config = require('../config')

log = require('../lib/log')
models = require('../lib/models')

module.exports = (socket)->
	require('./node')(socket)
