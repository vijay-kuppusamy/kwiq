const models = require('../setup/models');

module.exports.getExamQuestions = async function getExamQuestions(req, res) {
  try {
    const examQuestions = await models.ExamQuestion.findAll({
      attributes: ['id', 'questionId', 'userexamId', 'userAnswer', 'answer'],
      where: { userexamId: req.params.userexamId },
    });
    res.json(examQuestions);
  } catch (error) {
    res.json({ error: error.message });
  }
};

module.exports.getExamQuestion = async function getExamQuestion(req, res) {
  try {
    const examQuestion = await models.ExamQuestion.findOne({
      attributes: ['id', 'questionId', 'userexamId', 'userAnswer', 'answer'],
      where: {
        id: req.params.id,
      },
    });
    res.json(examQuestion);
  } catch (error) {
    res.json({ error: error.message });
  }
};

module.exports.createExamQuestion = function createExamQuestion(req, res) {
  try {
    const { body } = req;
    models.ExamQuestion.Create(body)
      .then(examQuestion => res.json(examQuestion))
      .catch((err) => {
        res.json({ message: err.message });
      });
  } catch (error) {
    res.json({ message: error.message });
  }
};

module.exports.updateExamQuestion = async function updateExamQuestion(req, res) {
  const { body } = req;
  try {
    const examQuestion = await models.ExamQuestion.update(body, {
      where: {
        id: body.id,
      },
    });
    res.json(examQuestion);
  } catch (error) {
    res.json({ message: error.message });
  }
};

module.exports.deleteExamQuestion = async function deleteExamQuestion(req, res) {
  const { body } = req;
  try {
    const examQuestion = await models.ExamQuestion.destroy({
      where: {
        id: body.id,
      },
    });
    res.json(examQuestion);
  } catch (error) {
    res.json({ message: error.message });
  }
};
