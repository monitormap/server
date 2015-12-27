expect = require("chai").expect
request = require('request')

config = require('./config')

describe('API',->
	it('tests',(done)->
		request.get(config.ADDRESS+"/api/tests",(err,res,body)->
			expect(err).to.be.null
			expect(res.statusCode).to.be.equal(200)
			x = JSON.parse(body)
			expect(x.s).to.be.true
			done()
		)
	)
)
