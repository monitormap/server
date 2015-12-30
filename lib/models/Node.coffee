Sequelize = require('sequelize')
module.exports = (DB)->

	Node = DB.define('node',{
		name:{type: Sequelize.STRING},
		owner:{type: Sequelize.STRING},
		mac:{type: Sequelize.STRING, unique: true},
		lat:{type: Sequelize.FLOAT},
		lon:{type: Sequelize.FLOAT},
		timedate:{type: Sequelize.DATE},

		channel_24:{type: Sequelize.INTEGER},
		channel_50:{type: Sequelize.INTEGER},
		channel_24_power:{type: Sequelize.INTEGER},
		channel_50_power:{type: Sequelize.INTEGER},
		client_24:{type: Sequelize.INTEGER},
		client_50:{type: Sequelize.INTEGER},

		ports:{type: Sequelize.INTEGER},
		ports_gb:{type: Sequelize.INTEGER},

		tx_bytes:{type: Sequelize.BIGINT},
		tx_packets:{type: Sequelize.BIGINT},
		rx_bytes:{type: Sequelize.BIGINT},
		rx_packets:{type: Sequelize.BIGINT},

		tx_24_bytes:{type: Sequelize.BIGINT},
		tx_24_packets:{type: Sequelize.BIGINT},
		rx_24_bytes:{type: Sequelize.BIGINT},
		rx_24_packets:{type: Sequelize.BIGINT},

		tx_50_bytes:{type: Sequelize.BIGINT},
		tx_50_packets:{type: Sequelize.BIGINT},
		rx_50_bytes:{type: Sequelize.BIGINT},
		rx_50_packets:{type: Sequelize.BIGINT},
	},{tableName:'node'})

	group = DB.define('node_group',{
		name:{type: Sequelize.STRING, unique: true},
		nodes:Sequelize.ARRAY(Sequelize.STRING),
	},{tableName:'node_group'})

	Node_DS = [
					'DS:client_24:GAUGE:120:0:NaN',
					'DS:client_50:GAUGE:120:0:NaN',

					'DS:ports:GAUGE:120:0:NaN',
					'DS:ports_gb:GAUGE:120:0:NaN',

					'DS:tx_24_bytes:DERIVE:120:0:NaN',
					'DS:tx_24_packets:DERIVE:120:0:NaN',
					'DS:rx_24_bytes:DERIVE:120:0:NaN',
					'DS:rx_24_packets:DERIVE:120:0:NaN',

					'DS:tx_50_bytes:DERIVE:120:0:NaN',
					'DS:tx_50_packets:DERIVE:120:0:NaN',
					'DS:rx_50_bytes:DERIVE:120:0:NaN',
					'DS:rx_50_packets:DERIVE:120:0:NaN'
				]

	Node_RRA = ['RRA:MIN:0.5:1:1440','RRA:AVERAGE:0.5:1:1440','RRA:MAX:0.5:1:1440','RRA:MIN:0.5:5:2880','RRA:AVERAGE:0.5:5:2880','RRA:MAX:0.5:5:2880']
	Global_DS = [
				'DS:count:GAUGE:120:0:NaN',
				'DS:client_24:GAUGE:120:0:NaN',
				'DS:client_50:GAUGE:120:0:NaN',

				'DS:tx_24_bytes:DERIVE:120:0:NaN',
				'DS:tx_24_packets:DERIVE:120:0:NaN',
				'DS:rx_24_bytes:DERIVE:120:0:NaN',
				'DS:rx_24_packets:DERIVE:120:0:NaN',

				'DS:tx_50_bytes:DERIVE:120:0:NaN',
				'DS:tx_50_packets:DERIVE:120:0:NaN',
				'DS:rx_50_bytes:DERIVE:120:0:NaN',
				'DS:rx_50_packets:DERIVE:120:0:NaN'
			]
	Global_RRA = ['RRA:MIN:0.5:1:1440','RRA:AVERAGE:0.5:1:1440','RRA:MAX:0.5:1:1440','RRA:MIN:0.5:5:2880','RRA:AVERAGE:0.5:5:2880','RRA:MAX:0.5:5:2880']

	return {RRA:Node_RRA,DB:Node,DS:Node_DS,global:{RRA:Global_RRA,DS:Global_DS},Group:group}
