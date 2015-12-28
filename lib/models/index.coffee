config = require('../../config').database
Sequelize = require('sequelize')
rrd = require('../rrd')
DB = new Sequelize(config.database, config.user, config.password, config)

node = require('./Node')(DB)
DB.sync({ force: false })
rrd.create('node',node)

module.exports = {Node:node,_db:DB,_lib:Sequelize}
