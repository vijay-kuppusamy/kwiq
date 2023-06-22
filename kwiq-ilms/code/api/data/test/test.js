const nodemailer = require('nodemailer');

// async..await is not allowed in global scope, must use a wrapper
async function main() {
  // create reusable transporter object using the default SMTP transport
  const transporter = nodemailer.createTransport({
    host: 'sg2plcpnl0050.prod.sin2.secureserver.net',
    // host: 'smtpout.secureserver.net',
    // host: 'mail.kwiqacademy.in',
    port: 465,
    // port: 587,
    secure: true,
    // secure: false,
    auth: {
      user: 'admin@kwiqacademy.in',
      pass: 'kwiq@cademy2019',
    },
  });

  // send mail with defined transport object
  const info = await transporter.sendMail({
    from: '"Kwiq Admin" <admin@kwiqacademy.in>', // sender address
    to: 'pk_vijayakumar@yahoo.com', // list of receivers
    subject: 'Welcome Vijay', // Subject line
    html: '<b>Welcome Vijay</b>', // html body
  });

  console.log('Message sent: %s', info.messageId);
  // Message sent: <b658f8ca-6296-ccf4-8306-87d57a0b4321@example.com>
}

main().catch(console.error);
