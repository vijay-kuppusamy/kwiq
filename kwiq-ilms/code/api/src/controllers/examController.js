const models = require('../setup/models');

module.exports.getAllExams = async function getAllExams(req, res) {
  try {
    const exams = await models.Exam.findAll({
      attributes: [
        'id',
        'name',
        'description',
        'image',
        'noOfQues',
        'markPerQue',
        'negativeMarkPerQue',
        'durationInMins',
        'isActive',
      ],
    });
    res.json(exams);
  } catch (error) {
    res.json({ error: error.message });
  }
};

module.exports.getExam = async function getExam(req, res) {
  try {
    const exam = await models.Exam.findOne({
      attributes: [
        'id',
        'name',
        'description',
        'image',
        'noOfQues',
        'markPerQue',
        'negativeMarkPerQue',
        'durationInMins',
        'isActive',
      ],
      where: {
        id: req.params.id,
      },
    });
    res.json(exam);
  } catch (error) {
    res.json({ error: error.message });
  }
};

module.exports.createExam = function createExam(req, res) {
  try {
    const { body } = req;
    models.Exam.findOrCreate({
      where: { name: body.name },
      defaults: {
        name: body.name,
        description: body.description,
        image: body.image,
        noOfQues: body.noOfQues,
        markPerQue: body.markPerQue,
        negativeMarkPerQue: body.negativeMarkPerQue,
        durationInMins: body.durationInMins,
        isActive: true,
      },
    })
      .then(([exam, created]) => {
        if (created) {
          res.json(exam);
        } else {
          res.json({ message: 'Exam configuration already exists' });
        }
      })
      .catch((err) => {
        res.json({ message: err.message });
      });
  } catch (error) {
    res.json({ message: error.message });
  }
};

module.exports.updateExam = async function updateExam(req, res) {
  const { body } = req;
  try {
    const exam = await models.Exam.update(body, {
      where: {
        id: body.id,
      },
    });
    res.json(exam);
  } catch (error) {
    res.json({ message: error.message });
  }
};

module.exports.deleteExam = async function deleteExam(req, res) {
  const { body } = req;
  try {
    const exam = await models.Exam.destroy({
      where: {
        id: body.id,
      },
    });
    res.json(exam);
  } catch (error) {
    res.json({ message: error.message });
  }
};
