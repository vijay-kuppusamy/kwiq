const express = require('express');

const controller = require('../controllers/examController');
const { authenticateAdmin } = require('../middlewares/authentication');

const router = express.Router();

router.get('/', (req, res) => {
  controller.getAllExams(req, res);
});

router.get('/:id', (req, res) => {
  controller.getExam(req, res);
});

router.post('/', authenticateAdmin, (req, res) => {
  controller.createExam(req, res);
});

router.put('/', authenticateAdmin, (req, res) => {
  controller.updateExam(req, res);
});

router.delete('/', authenticateAdmin, (req, res) => {
  controller.deleteExam(req, res);
});

module.exports = router;
