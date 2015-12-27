config = require('../config').database
Sequelize = require('sequelize')
DB = new Sequelize(config.database, config.user, config.password, config)
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
	status:{type:Sequelize.BOOLEAN},
	client_24:{type: Sequelize.INTEGER},
	client_50:{type: Sequelize.INTEGER},

	ports:{type: Sequelize.INTEGER},
	ports_gb:{type: Sequelize.INTEGER},

	traffic_tx_bytes:{type: Sequelize.BIGINT},
	traffic_tx_packets:{type: Sequelize.BIGINT},
	traffic_rx_bytes:{type: Sequelize.BIGINT},
	traffic_rx_packets:{type: Sequelize.BIGINT},

	traffic_tx24_bytes:{type: Sequelize.BIGINT},
	traffic_tx24_packets:{type: Sequelize.BIGINT},
	traffic_rx24_bytes:{type: Sequelize.BIGINT},
	traffic_rx24_packets:{type: Sequelize.BIGINT},

	traffic_tx50_bytes:{type: Sequelize.BIGINT},
	traffic_tx50_packets:{type: Sequelize.BIGINT},
	traffic_rx50_bytes:{type: Sequelize.BIGINT},
	traffic_rx50_packets:{type: Sequelize.BIGINT},
},{tableName:'node'});

DB.sync({ force: false });

module.exports = {Node:Node,_db:DB,_lib:Sequelize};
