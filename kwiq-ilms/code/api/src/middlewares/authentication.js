const jwt = require('jsonwebtoken');
const { JWT_SEC } = require('../config/env');

module.exports.authenticateUser = function authenticateUser(req, res, next) {
  try {
    let token = req.headers.authorization;
    if (token.startsWith('Bearer ')) {
      // Remove Bearer from string
      token = token.slice(7, token.length);
    }
    if (!token) {
      res.status(401).send({ error: 'Access denied' });
    }
    const verified = jwt.verify(token, JWT_SEC);
    const decoded = jwt.decode(token, { complete: true });
    req.userId = decoded.payload.id;
    req.userRole = decoded.payload.role;
    next();
  } catch (error) {
    res.status(400).send({ error: 'Access denied' });
  }
};

module.exports.authenticateAdmin = function authenticateAdmin(req, res, next) {
  try {
    let token = req.headers.authorization;
    if (token.startsWith('Bearer ')) {
      // Remove Bearer from string
      token = token.slice(7, token.length);
    }
    if (!token) {
      res.status(401).send({ error: 'Access denied' });
    }
    const verified = jwt.verify(token, JWT_SEC);
    const decoded = jwt.decode(token, { complete: true });

    if (decoded.payload.role !== 'admin') {
      res.status(401).send({ error: 'Access denied' });
    }
    req.userId = decoded.payload.id;
    req.userRole = decoded.payload.role;

    next();
  } catch (error) {
    res.status(400).send({ error: 'Access denied' });
  }
};
