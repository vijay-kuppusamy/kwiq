const express = require('express');

const controller = require('../controllers/locationController');

const router = express.Router();

router.get('/location/:vehicleNumber', (req, res) => {
  controller.getLocation(req, res);
});

router.post('/', (req, res) => {
  controller.updateOrCreate(req, res);
});

module.exports = router;
