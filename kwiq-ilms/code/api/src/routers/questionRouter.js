const express = require('express');
const controller = require('../controllers/questionController');
const { authenticateAdmin } = require('../middlewares/authentication');

const router = express.Router();

router.get('/:page/:pageSize', (req, res) => {
  controller.getQuestions(req, res);
});

router.get('/:id', (req, res) => {
  controller.findById(req, res);
});

router.get('/search/:year/:subjectId', (req, res) => {
  controller.searchQuestions(req, res);
});

router.post('/', authenticateAdmin, (req, res) => {
  controller.createQuestion(req, res);
});

router.put('/', authenticateAdmin, (req, res) => {
  controller.updateQuestion(req, res);
});

module.exports = router;
