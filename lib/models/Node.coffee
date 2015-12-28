Sequelize = require('sequelize')
module.exports = (DB)->

	Node = DB.define('node',{
		name:{type: Sequelize.STRING},
		owner:{type: Sequelize.STRING},
		mac:{type: Sequelize.STRING, unique: true},
		lat:{type: Sequelize.FLOAT},
		lon:{type: Sequelize.FLOAT},

		channel_24:{type: Sequelize.INTEGER},
		channel_50:{type: Sequelize.INTEGER},
		channel_24_power:{type: Sequelize.INTEGER},
		channel_50_power:{type: Sequelize.INTEGER},
		datetime:{type: Sequelize.DATE},
		client_24:{type: Sequelize.INTEGER},
		client_50:{type: Sequelize.INTEGER},

		ports:{type: Sequelize.INTEGER},
		ports_gb:{type: Sequelize.INTEGER},

		traffic_tx_bytes:{type: Sequelize.BIGINT},
		traffic_tx_packets:{type: Sequelize.BIGINT},
		traffic_rx_bytes:{type: Sequelize.BIGINT},
		traffic_rx_packets:{type: Sequelize.BIGINT},

		traffic_tx_24_bytes:{type: Sequelize.BIGINT},
		traffic_tx_24_packets:{type: Sequelize.BIGINT},
		traffic_rx_24_bytes:{type: Sequelize.BIGINT},
		traffic_rx_24_packets:{type: Sequelize.BIGINT},

		traffic_tx_50_bytes:{type: Sequelize.BIGINT},
		traffic_tx_50_packets:{type: Sequelize.BIGINT},
		traffic_rx_50_bytes:{type: Sequelize.BIGINT},
		traffic_rx_50_packets:{type: Sequelize.BIGINT},
	},{tableName:'node'})

	group = DB.define('node_group',{
		name:{type: Sequelize.STRING, unique: true},
		nodes:Sequelize.ARRAY(Sequelize.STRING),
	},{tableName:'node_group'})

	Node_DS = [
					'DS:upstate:GAUGE:120:0:1',
					'DS:clients:GAUGE:120:0:NaN',
					'DS:clients_24:GAUGE:120:0:NaN',
					'DS:clients_50:GAUGE:120:0:NaN',
					'DS:load:GAUGE:120:0:NaN',
					'DS:uptime:DERIVE:120:0:NaN',

					'DS:rx_bytes:DERIVE:120:0:NaN',
					'DS:rx_packets:DERIVE:120:0:NaN',
					'DS:tx_bytes:DERIVE:120:0:NaN',
					'DS:tx_packets:DERIVE:120:0:NaN',

					'DS:rx24_bytes:DERIVE:120:0:NaN',
					'DS:rx24_packets:DERIVE:120:0:NaN',
					'DS:tx24_bytes:DERIVE:120:0:NaN',
					'DS:tx24_packets:DERIVE:120:0:NaN',

					'DS:rx50_bytes:DERIVE:120:0:NaN',
					'DS:rx50_packets:DERIVE:120:0:NaN',
					'DS:tx50_bytes:DERIVE:120:0:NaN',
					'DS:tx50_packets:DERIVE:120:0:NaN',

					'DS:mem_free:DERIVE:120:0:NaN',
					'DS:mem_usage:DERIVE:120:0:NaN',
					'DS:mem_total:DERIVE:120:0:NaN',
					'DS:mem_cached:DERIVE:120:0:NaN',
					'DS:mem_buffers:DERIVE:120:0:NaN',
				]

	Node_RRA = ['RRA:MIN:0.5:1:1440','RRA:AVERAGE:0.5:1:1440','RRA:MAX:0.5:1:1440','RRA:MIN:0.5:5:2880','RRA:AVERAGE:0.5:5:2880','RRA:MAX:0.5:5:2880']
	Global_DS = [
				'DS:nodes:GAUGE:120:0:NaN',
				'DS:clients:GAUGE:120:0:NaN',
				'DS:clients24:GAUGE:120:0:NaN',
				'DS:clients50:GAUGE:120:0:NaN',
				'DS:rx_bytes:DERIVE:120:0:NaN',
				'DS:rx_packets:DERIVE:120:0:NaN',
				'DS:tx_bytes:DERIVE:120:0:NaN',
				'DS:tx_packets:DERIVE:120:0:NaN',

				'DS:rx24_bytes:DERIVE:120:0:NaN',
				'DS:rx24_packets:DERIVE:120:0:NaN',
				'DS:tx24_bytes:DERIVE:120:0:NaN',
				'DS:tx24_packets:DERIVE:120:0:NaN',

				'DS:rx50_bytes:DERIVE:120:0:NaN',
				'DS:rx50_packets:DERIVE:120:0:NaN',
				'DS:tx50_bytes:DERIVE:120:0:NaN',
				'DS:tx50_packets:DERIVE:120:0:NaN',

				'DS:mem_total:DERIVE:120:0:NaN'
			]
	Global_RRA = ['RRA:MIN:0.5:1:1440','RRA:AVERAGE:0.5:1:1440','RRA:MAX:0.5:1:1440','RRA:MIN:0.5:5:2880','RRA:AVERAGE:0.5:5:2880','RRA:MAX:0.5:5:2880']

	return {RRA:Node_RRA,DB:Node,DS:Node_DS,global:{RRA:Global_RRA,DS:Global_DS},Group:group}
