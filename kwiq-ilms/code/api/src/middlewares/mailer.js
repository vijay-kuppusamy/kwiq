const nodemailer = require('nodemailer');

const {
  MAIL_HOST, MAIL_PORT, MAIL_SECURE, MAIL_USER, MAIL_KEY,
} = require('../config/env');

module.exports.sendMail = async function sendMail(toAddress, mailSubject, htmlMsg) {
  //
  const transporter = nodemailer.createTransport({
    host: MAIL_HOST,
    port: MAIL_PORT,
    secure: MAIL_SECURE,
    auth: {
      user: MAIL_USER,
      pass: MAIL_KEY,
    },
  });
  //
  const info = await transporter.sendMail({
    from: '"Kwiq Admin" <admin@kwiqacademy.in>', // sender address
    to: toAddress, // list of receivers
    subject: mailSubject, // Subject line
    html: htmlMsg, // html body
  });
  //
  return info;
};
