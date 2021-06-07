async function connect() {
    if(global.connection && global.connection.state != 'disconnected') 
      return global.connection;

    const mysql = require("mysql2/promise");
    const connection = await mysql.createConnection("mysql://root:@localhost:3306/db_test");
    
    console.log("Conectou no MySQL!");
    global.connection = connection;
    
    return connection;
}

async function selectContacts() {
  const conn = await connect();
  const [rows] = await conn.query("SELECT * FROM tb_contacts");

  return await rows;
}

module.exports = {selectContacts};