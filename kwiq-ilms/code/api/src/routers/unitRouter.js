const express = require('express');

const controller = require('../controllers/unitController');
const { unitValidation, updateUnitValidation } = require('../validators/unitValidator');
const { authenticateAdmin } = require('../middlewares/authentication');

const router = express.Router();

router.get('/:chapterId', (req, res) => {
  controller.getAllUnits(req, res);
});

router.get('/unit/:id', (req, res) => {
  controller.getUnit(req, res);
});

router.post('/', authenticateAdmin, (req, res) => {
  const { error } = unitValidation(req.body);
  if (error) {
    res.json({ error: error.details[0].message });
  } else {
    controller.createUnit(req, res);
  }
});

router.put('/', authenticateAdmin, (req, res) => {
  const { error } = updateUnitValidation(req.body);
  if (error) {
    res.json({ error: error.details[0].message });
  } else {
    controller.updateUnit(req, res);
  }
});

router.delete('/', authenticateAdmin, (req, res) => {
  controller.deleteUnit(req, res);
});

module.exports = router;
