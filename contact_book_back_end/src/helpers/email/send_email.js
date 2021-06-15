const nodemailer = require('nodemailer');
const ejs = require('ejs');

function sendEmail(userEmail, name) {
  // Adding html style to email content
  ejs.renderFile(__dirname + "/email.ejs", function(error, data) {

    if(error) {
      console.log(error);
    } else {
      // Configuration for an personal email 
      const personalTransport = nodemailer.createTransport({
        host: "smtp.gmail.com",
        port: 587,
        auth: {
          user: "rodrigo.devtests@gmail.com",
          // pass: "your password here"
        }
      });
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
        from: `Rodrigo Destefano <rodrigo.devtests@gmail.com>`,
        to: userEmail,
        subject: `${name}! Welcome to Contact's Book!`,
        html: data,
      });
    }
  });
}

module.exports = {sendEmail};