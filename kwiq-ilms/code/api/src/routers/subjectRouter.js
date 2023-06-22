const express = require('express');

const controller = require('../controllers/subjectController');
const { subjectValidation, updateSubjectValidation } = require('../validators/subjectValidator');
const { authenticateAdmin } = require('../middlewares/authentication');

const router = express.Router();

router.get('/:courseId', (req, res) => {
  controller.getAllSubjects(req, res);
});

router.get('/:name/:courseId', (req, res) => {
  controller.getSubject(req, res);
});

router.post('/', authenticateAdmin, (req, res) => {
  const { error } = subjectValidation(req.body);
  if (error) {
    res.json({ error: error.details[0].message });
  } else {
    controller.createSubject(req, res);
  }
});

router.put('/', authenticateAdmin, (req, res) => {
  const { error } = updateSubjectValidation(req.body);
  if (error) {
    res.json({ error: error.details[0].message });
  } else {
    controller.updateSubject(req, res);
  }
});

router.delete('/', authenticateAdmin, (req, res) => {
  controller.deleteSubject(req, res);
});

module.exports = router;
