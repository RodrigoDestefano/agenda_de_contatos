const {Model, DataTypes} = require('sequelize');
const bcrypt = require('bcryptjs');

class User extends Model {
  static init(sequelize) {
    super.init({
      name: DataTypes.STRING,
      password: DataTypes.STRING,
      email: DataTypes.STRING,
    }, {
      sequelize,
      // Password encryption
      hooks: {beforeCreate: (user) => {
        const salt = bcrypt.genSaltSync();
        user.password = bcrypt.hashSync(user.password, salt);
      },},
    })
  }

  // DB Relationship:
  static associate(models) {
    // (User) 1 : N (Contacts)
    this.hasMany(models.Contact, {foreignKey: 'user_id', as: 'contact'});
    // (User) 1 : N (Groups)
    this.hasMany(models.Group, {foreignKey: 'user_id', as: 'group'});
  }
}

module.exports = User;