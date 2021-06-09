const Sequelize = require('sequelize');
const dbConfig = require('../config/database');

const User = require('../models/User');
const Contact = require('../models/Contact');

const connection = new Sequelize(dbConfig);

User.init(connection);
Contact.init(connection);

// Indicative of relationship in the database
User.associate(connection.models);
Contact.associate(connection.models);

module.exports = connection;