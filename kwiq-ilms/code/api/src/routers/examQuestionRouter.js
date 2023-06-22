const express = require('express');

const controller = require('../controllers/examQuestionController');

const router = express.Router();

router.get('/:userexamId', (req, res) => {
  controller.getExamQuestions(req, res);
});

router.get('/:id/:userexamId', (req, res) => {
  controller.getExamQuestions(req, res);
});

router.post('/', (req, res) => {
  controller.createExamQuestion(req, res);
});

router.put('/', (req, res) => {
  controller.updateExamQuestion(req, res);
});

router.delete('/', (req, res) => {
  controller.deleteExamQuestion(req, res);
});

module.exports = router;
