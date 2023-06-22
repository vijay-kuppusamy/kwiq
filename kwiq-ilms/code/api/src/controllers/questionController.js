const models = require('../setup/models');

module.exports.getQuestions = async function getQuestions(req, res) {
  try {
    const { page } = req.params;
    const { pageSize } = req.params;

    const offset = parseInt(page, 10) * parseInt(pageSize, 10);
    const limit = parseInt(pageSize, 10);
    const questions = await models.Question.findAll({
      attributes: [
        'id',
        'neetQuestionyear',
        'neetQuestionNo',
        'subjectId',
        'chapterId',
        'answer',
        'isActive',
      ],
      offset,
      limit,
    });
    res.json(questions);
  } catch (error) {
    res.json({ error });
  }
};

module.exports.searchQuestions = async function searchQuestions(req, res) {
  try {
    const whereClause = {};
    if (req.params.year) {
      whereClause.neetQuestionyear = req.params.year;
    }
    if (req.params.subjectId) {
      whereClause.subjectId = req.params.subjectId;
    }

    const questions = await models.Question.findAll({
      attributes: [
        'id',
        'neetQuestionyear',
        'neetQuestionNo',
        'subjectId',
        'chapterId',
        'answer',
        'isActive',
      ],
      where: whereClause,
    });
    res.json(questions);
  } catch (error) {
    res.json({ error });
  }
};

module.exports.findById = async function findById(req, res) {
  try {
    const question = await models.Question.findOne({
      where: {
        id: req.params.id,
      },
    });
    res.json(question);
  } catch (err) {
    res.json({ message: err });
  }
};

module.exports.createQuestion = function createQuestion(req, res) {
  try {
    const { body } = req;

    const whereStatement = {};

    if (body.question) {
      whereStatement.question = body.question;
    }
    if (body.subjectId) {
      whereStatement.subjectId = body.subjectId;
    }
    if (body.chapterId) {
      whereStatement.chapterId = body.chapterId;
    }

    models.Question.findOrCreate({
      where: whereStatement,
      defaults: {
        question: body.question,
        optionA: body.optionA,
        optionB: body.optionB,
        optionC: body.optionC,
        optionD: body.optionD,
        answer: body.answer,
        neetQuestionyear: body.neetQuestionyear,
        neetQuestionNo: body.neetQuestionNo,
        isActive: body.isActive,
        subjectId: body.subjectId,
        chapterId: body.chapterId,
      },
    })
      .then(([question, created]) => {
        if (created) {
          res.json(question);
        } else {
          res.json({ message: 'Question name already exists' });
        }
      })
      .catch((err) => {
        res.json({ err: err.message });
      });
  } catch (error) {
    res.json({ error });
  }
};

module.exports.updateQuestion = async function updateQuestion(req, res) {
  const { body } = req;
  try {
    const question = await models.Question.update(
      {
        question: body.question,
        optionA: body.optionA,
        optionB: body.optionB,
        optionC: body.optionC,
        optionD: body.optionD,
        answer: body.answer,
        neetQuestionyear: body.neetQuestionyear,
        neetQuestionNo: body.neetQuestionNo,
        isActive: body.isActive,
        subjectId: body.subjectId,
        chapterId: body.chapterId,
      },
      {
        where: {
          id: body.id,
        },
      },
    );
    res.json(`Saved :${question}`);
  } catch (error) {
    res.json({ error: error.message });
  }
};
