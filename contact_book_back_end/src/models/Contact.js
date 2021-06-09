const {Model, DataTypes} = require('sequelize');

class Contact extends Model {
  static init(sequelize) {
    super.init({
      name: DataTypes.STRING,
    }, {sequelize})
  }

  // DB Relationship: (User) 1 : N (Contacts)
  static associate(models) {
    this.belongsTo(models.User, {foreignKey: 'user_id', as: 'user'});
  }
}

module.exports = Contact;