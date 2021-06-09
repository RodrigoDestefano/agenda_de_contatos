const Sequelize = require('sequelize');
const dbConfig = require('../config/database');

const User = require('../models/User');
const Contact = require('../models/Contact');
const Address = require('../models/Address');
const Group = require('../models/Group');

const connection = new Sequelize(dbConfig);

User.init(connection);
Contact.init(connection);
Address.init(connection);
Group.init(connection);

// Indicative of relationships in the database
User.associate(connection.models);
Contact.associate(connection.models);
Address.associate(connection.models);
Group.associate(connection.models);

module.exports = connection;