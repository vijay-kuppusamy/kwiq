const models = require('../setup/models');

module.exports.getAllUserExams = async function getAllUserExams(req, res) {
  try {
    const userexams = await models.UserExam.findAll({
      attributes: ['id', 'startTime', 'endTime', 'status', 'score'],
    });
    res.json(userexams);
  } catch (error) {
    res.json({ error: error.message });
  }
};

module.exports.getUserExamByUser = async function getUserExamByUser(req, res) {
  try {
    const userexams = await models.UserExam.findAll({
      attributes: [
        'id',
        'startTime',
        'endTime',
        'status',
        'score',
        'questionsAnswered',
        'correctAnswers',
        'wrongAnswers',
      ],
      where: {
        userId: req.params.id,
      },
    });
    res.json(userexams);
  } catch (error) {
    res.json({ error: error.message });
  }
};

module.exports.getUserExam = async function getUserExam(req, res) {
  try {
    const userexam = await models.UserExam.findOne({
      attributes: [
        'id',
        'startTime',
        'endTime',
        'status',
        'score',
        'questionsAnswered',
        'correctAnswers',
        'wrongAnswers',
      ],
      where: {
        id: req.params.id,
      },
    });
    res.json(userexam);
  } catch (error) {
    res.json({ error: error.message });
  }
};

module.exports.createUserExam = function createUserExam(req, res) {
  try {
    const { body } = req;
    models.UserExam.create(body)
      .then(userexam => res.json(userexam))
      .catch((err) => {
        res.json({ message: err.message });
      });
  } catch (error) {
    res.json({ message: error.message });
  }
};

module.exports.updateUserExam = async function updateUserExam(req, res) {
  const { body } = req;
  try {
    const userexam = await models.UserExam.update(body, {
      where: {
        id: body.id,
      },
    });
    res.json(userexam);
  } catch (error) {
    res.json({ message: error.message });
  }
};

module.exports.deleteUserExam = async function deleteUserExam(req, res) {
  const { body } = req;
  try {
    const userexam = await models.UserExam.destroy({
      where: {
        id: body.id,
      },
    });
    res.json(userexam);
  } catch (error) {
    res.json({ message: error.message });
  }
};
