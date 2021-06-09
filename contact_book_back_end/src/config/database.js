// Databse parameters
module.exports = {
    host: "localhost",
    dialect: 'mysql',
    username: 'root',
    password: '',
    // Database name, already created in MySql Workbench
    database: 'db_contactbook',
    define: {
        timestamps: true,
        underscored: true,
    },
};