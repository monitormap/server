config = require('../../config')

intervalObj = {}

services = ['toRRD']

module.exports.init = ->
	for service in services
		module.exports.start(service)

module.exports.start = (service) ->
	intervalObj[service] = setInterval(require('./'+service),config.times[service]);

module.exports.stop = (service) ->
	clearInterval(intervalObj[service])
