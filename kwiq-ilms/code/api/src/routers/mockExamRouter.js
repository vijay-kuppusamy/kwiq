const express = require('express');
const controller = require('../controllers/mockExamController');
const examController = require('../controllers/userExamController');

const router = express.Router();

router.post('/create', (req, res) => {
  controller.createMockExam(req, res);
});

router.post('/save', (req, res) => {
  controller.saveMockExam(req, res);
});

router.get('/myexams/:id', (req, res) => {
  examController.getUserExamByUser(req, res);
});

module.exports = router;
