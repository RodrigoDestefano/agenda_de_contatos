(async () => {
  try {
  const db = require("./db");
  
  console.log("Começou!");
  console.log("SELECT * FROM tb_contacts");
  
  const contacts = await db.selectContacts();
  
  console.log(contacts);
  } catch(e) {
    console.log(e);
  }
})();