const { Model, DataTypes } = require('sequelize');

class Group extends Model {
  static init(sequelize) {
    super.init({
      name: DataTypes.STRING
    }, {
        sequelize,
        tableName: 'groups'
    })
  }

  // DB Relationships:
  static associate(models) {
    // (User) 1 : N (Groups)
    this.belongsTo(models.User, {foreignKey: 'user_id', as: 'user'});
    // (Contacts) N : M (Groups)
    this.belongsToMany(models.Contact, { foreignKey: 'group_id', through: 'contacts_groups', as: 'contacts'});
  }
}

module.exports = Group;