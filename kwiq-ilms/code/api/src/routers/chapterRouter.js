const express = require('express');

const controller = require('../controllers/chapterController');
const { chapterValidation } = require('../validators/chapterValidator');
const { authenticateAdmin } = require('../middlewares/authentication');

const router = express.Router();

router.get('/:subjectId', (req, res) => {
  controller.getAllChapters(req, res);
});

router.get('/:name/:subjectId', (req, res) => {
  controller.getChapter(req, res);
});

router.post('/', authenticateAdmin, (req, res) => {
  const { error } = chapterValidation(req.body);
  if (error) {
    res.json({ error: error.details[0].message });
  } else {
    controller.createChapter(req, res);
  }
});

router.put('/', authenticateAdmin, (req, res) => {
  const { error } = chapterValidation(req.body);
  if (error) {
    res.json({ error: error.details[0].message });
  } else {
    controller.updateChapter(req, res);
  }
});

router.delete('/', authenticateAdmin, (req, res) => {
  controller.deleteChapter(req, res);
});

module.exports = router;
