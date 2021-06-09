const nodemailer = require('nodemailer');
const ejs = require('ejs');

function sendEmail(userEmail, name) {
  ejs.renderFile(__dirname + "/email.ejs", function(error, data) {

    if(error) {
      console.log(error);
    } else {
      // Configuration for tests by https://mailtrap.io/ plataform
      const transport = nodemailer.createTransport({
        host: "smtp.mailtrap.io",
        port: 2525,
        auth: {
          user: "f713f883e3273c",
          pass: "dac68a582f0f12"
        }
      });

      transport.sendMail({
        from: `Destefano <from@mail.com>`,
        to: userEmail,
        subject: `${name}! Welcome to ContactsBook!`,
        html: data,
      });
    }
  });
}

module.exports = {sendEmail};