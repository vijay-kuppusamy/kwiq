const dotenv = require('dotenv');

// Load .env
dotenv.config();

// Environment
const NODE_ENV = process.env.NODE_ENV || 'production';

// JWT Sectet
// eslint-disable-next-line prefer-destructuring
const JWT_SEC = process.env.JWT_SEC || 'kWiQ!aCaDeMy!UsEr!Sec';

// Port
const HOST = '127.0.0.1';

// Port
const PORT = 40000;
const MAIL_HOST = 'sg2plcpnl0050.prod.sin2.secureserver.net';
const MAIL_PORT = 465;
const MAIL_SECURE = true;
const MAIL_USER = 'admin@kwiqacademy.in';
const MAIL_KEY = 'kwiq@cademy2019';

module.exports = {
  NODE_ENV,
  PORT,
  JWT_SEC,
  HOST,
  MAIL_HOST,
  MAIL_PORT,
  MAIL_SECURE,
  MAIL_USER,
  MAIL_KEY,
};
