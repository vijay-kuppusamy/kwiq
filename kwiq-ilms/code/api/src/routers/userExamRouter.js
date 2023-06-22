const express = require('express');

const controller = require('../controllers/userExamController');

const router = express.Router();

router.get('/', (req, res) => {
  controller.getAllUserExams(req, res);
});

router.get('/:id', (req, res) => {
  controller.getUserExam(req, res);
});

router.post('/', (req, res) => {
  controller.createUserExam(req, res);
});

router.put('/', (req, res) => {
  controller.updateUserExam(req, res);
});

router.delete('/', (req, res) => {
  controller.deleteUserExam(req, res);
});

module.exports = router;
