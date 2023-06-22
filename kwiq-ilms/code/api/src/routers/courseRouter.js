const express = require('express');

const controller = require('../controllers/courseController');
const { courseValidation } = require('../validators/courseValidator');
const { authenticateAdmin } = require('../middlewares/authentication');

const router = express.Router();

router.get('/', (req, res) => {
  controller.getAllCourses(req, res);
});

router.get('/:name', (req, res) => {
  controller.getCourse(req, res);
});

router.post('/', authenticateAdmin, (req, res) => {
  const { error } = courseValidation(req.body);
  if (error) {
    res.json({ error: error.details[0].message });
  } else {
    controller.createCourse(req, res);
  }
});

router.put('/', authenticateAdmin, (req, res) => {
  controller.updateCourse(req, res);
});

router.delete('/', authenticateAdmin, (req, res) => {
  controller.deleteCourse(req, res);
});

module.exports = router;
