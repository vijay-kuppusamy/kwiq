const express = require('express');
const path = require('path');
const controller = require('../controllers/userController');

const {
  registrationValidation,
  loginValidation,
  updateValidation,
  resetValidation,
} = require('../validators/userValidator');

const router = express.Router();

router.get('/', (req, res) => {
  res.sendFile(path.join(`${__dirname}/../home.html`));
});

router.post('/login', (req, res) => {
  const { error } = loginValidation(req.body);
  if (error) {
    res.json({ error: error.details[0].message });
  } else {
    controller.loginUser(req, res);
  }
});

router.post('/register', (req, res) => {
  const { error } = registrationValidation(req.body);
  if (error) {
    res.json({ error: error.details[0].message });
  } else {
    controller.saveUser(req, res);
  }
});

router.post('/update', (req, res) => {
  const { error } = updateValidation(req.body);
  if (error) {
    res.json({ error: error.details[0].message });
  } else {
    controller.updateUser(req, res);
  }
});

router.post('/reset', (req, res) => {
  const { error } = resetValidation(req.body);
  if (error) {
    res.json({ error: error.details[0].message });
  } else {
    controller.resetUser(req, res);
  }
});

module.exports = router;
