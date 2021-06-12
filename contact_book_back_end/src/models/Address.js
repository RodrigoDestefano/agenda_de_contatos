const { Model, DataTypes } = require('sequelize');

class Address extends Model {
  static init(sequelize) {
    super.init({
      phone: DataTypes.STRING,
      email: DataTypes.STRING,
      zip_code: DataTypes.STRING,
      street: DataTypes.STRING,
      number: DataTypes.STRING,
      district: DataTypes.STRING,
      city: DataTypes.STRING,
      uf: DataTypes.STRING,
    }, {sequelize})
  }

  // DB Relationship:
  static associate(models) {
    // (Contact) 1 : N (Addresses)
    this.belongsTo(models.Contact, { foreignKey: 'contact_id', as: 'contact'});
  }
}

module.exports = Address;