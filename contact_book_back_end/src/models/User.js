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

  // DB Relationship: (User) 1 : N (Contacts)
  static associate(models) {
    this.hasMany(models.Contact, {foreignKey: 'user_id', as: 'contact'});
  }
}

module.exports = User;