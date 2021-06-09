const {Model, DataTypes} = require('sequelize');

class Contact extends Model {
  static init(sequelize) {
    super.init({
      name: DataTypes.STRING,
      phone: DataTypes.STRING,
      email: DataTypes.STRING,
      zip_code: DataTypes.STRING,
      street: DataTypes.STRING,
      number: DataTypes.STRING,
      district: DataTypes.STRING,
      city: DataTypes.STRING,
    }, {sequelize})
  }

  // DB Relationships:
  static associate(models) {
    // (User) 1 : N (Contacts)
    this.belongsTo(models.User, {foreignKey: 'user_id', as: 'user'});
    // (Contact) 1 : N (Addresses)
    this.hasMany(models.Address, {foreignKey: 'contact_id', as: 'address'});
    // (Contacts) N : M (Groups)
    this.belongsToMany(models.Group, { foreignKey: 'contact_id', through: 'contacts_groups', as: 'groups'});
  }
}

module.exports = Contact;