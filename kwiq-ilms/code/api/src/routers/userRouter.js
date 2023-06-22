const express = require('express');
const controller = require('../controllers/userController');

const router = express.Router();

router.get('/', (req, res) => {
  controller.findAllUsers(req, res);
});

router.get('/:id', (req, res) => {
  controller.findById(req, res);
});

router.delete('/', (req, res) => {
  controller.deleteUser(req, res);
});

module.exports = router;
