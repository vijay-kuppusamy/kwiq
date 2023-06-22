const models = require('../setup/models');

async function getExamDetails(examId) {
  const exam = await models.Exam.findOne({
    where: { id: examId },
  }).catch(e => e.message);
  return exam;
}

async function getQuestions(name, nos) {
  const sql = `select id, answer, subjectId from questions where subjectId = (select id from subjects where name = '${name}') order by rand() limit ${nos}`;
  const questions = await models.sequelize
    .query(sql, {
      model: models.Question,
      mapToModel: true,
    })
    .catch(e => e.message);
  return questions;
}

async function constructUserExam(userId, examId) {
  const userExam = {};
  userExam.userId = userId;
  userExam.examId = examId;
  userExam.startTime = null;
  userExam.endTime = null;
  userExam.status = null;
  userExam.score = null;
  //
  return userExam;
}

function constructQuestion(obj) {
  const question = {};
  question.questionId = obj.id;
  question.userexamId = null;
  question.userAnswer = null;
  question.answer = obj.answer;
  return question;
}

async function constructExam(userId, examId) {
  //
  // getting exam details
  const exam = await getExamDetails(examId);
  const noOfQues = await exam.noOfQues;

  // creating user exam
  const userexam = await constructUserExam(userId, examId);
  const userexamId = await userexam.id;

  // constructing questions
  const questions = [];
  //
  const phyQuestions = await getQuestions('Physics', noOfQues / 4);
  const cheQuestions = await getQuestions('Chemistry', noOfQues / 4);
  const bioQuestions = await getQuestions('Biology', noOfQues / 2);

  for (let index = 0; index < phyQuestions.length; index += 1) {
    const element = phyQuestions[index];
    questions.push(constructQuestion(element));
  }
  for (let index = 0; index < cheQuestions.length; index += 1) {
    const element = cheQuestions[index];
    questions.push(constructQuestion(element));
  }
  for (let index = 0; index < bioQuestions.length; index += 1) {
    const element = bioQuestions[index];
    questions.push(constructQuestion(element));
  }

  userexam.exam = exam;
  userexam.examquestions = questions;

  // console.log(JSON.stringify(userexam));

  return userexam;
}

// Create mock exam,
// nothing is updated in db
// Just creating the exam
module.exports.createMockExam = async function createMockExam(req, res) {
  try {
    const { body } = req;
    const { userId } = body;
    const { examId } = body;
    //
    constructExam(userId, examId)
      .then(response => res.json(response))
      .catch(error => res.json(error.message));
    //
  } catch (error) {
    res.json({ error: error.message });
  }
};

function getQuestionsAnswered(questions) {
  let questionsAnswered = 0;
  try {
    //
    if (questions != null && questions.length > 0) {
      for (let index = 0; index < questions.length; index += 1) {
        const element = questions[index];
        if (element != null && element.userAnswer != null) {
          questionsAnswered += 1;
        }
      }
    }
  } catch (error) {
    // console.log(error);
  }
  return questionsAnswered;
}

function getCorrectAnswers(questions) {
  let correctAnswers = 0;
  try {
    //
    if (questions != null && questions.length > 0) {
      for (let index = 0; index < questions.length; index += 1) {
        const element = questions[index];
        if (
          element != null
          && element.userAnswer != null
          && element.userAnswer === element.answer
        ) {
          correctAnswers += 1;
        }
      }
    }
  } catch (error) {
    // console.log(error);
  }
  return correctAnswers;
}

function getWrongAnswers(questions) {
  let wrongAnswers = 0;
  try {
    //
    if (questions != null && questions.length > 0) {
      for (let index = 0; index < questions.length; index += 1) {
        const element = questions[index];
        if (
          element != null
          && element.userAnswer != null
          && element.userAnswer !== element.answer
        ) {
          wrongAnswers += 1;
        }
      }
    }
  } catch (error) {
    // console.log(error);
  }
  return wrongAnswers;
}

async function createUserExam(userExam) {
  const userexam = await models.UserExam.create(userExam).catch(e => e.message);
  return userexam;
}

async function createExamQuestions(userExamId, questions) {
  //
  const updatedQuestions = [];

  try {
    //
    if (questions != null && questions.length > 0) {
      for (let index = 0; index < questions.length; index += 1) {
        const element = questions[index];
        if (element != null) {
          //
          const question = {};
          question.questionId = element.questionId;
          question.userexamId = userExamId;
          question.userAnswer = element.userAnswer;
          question.answer = element.answer;
          //
          updatedQuestions.push(question);
        }
      }
    }
    //
    const insertedQus = await models.ExamQuestion.bulkCreate(updatedQuestions, {
      returning: true,
    }).catch(e => e.message);
    //
    return insertedQus;
  } catch (error) {
    // console.log(error);
    return { error };
  }
}

module.exports.saveMockExam = async function saveMockExam(req, res) {
  try {
    const { body } = req;
    const { exam } = body;
    const questions = body.examquestions;
    //
    const questionsAnswered = getQuestionsAnswered(questions);
    const correctAnswers = getCorrectAnswers(questions);
    const wrongAnswers = getWrongAnswers(questions);
    //
    const { markPerQue } = exam;
    const negativeMark = exam.negativeMarkPerQue;
    const addMark = correctAnswers * markPerQue;
    const minusMark = wrongAnswers * negativeMark;
    const score = addMark - minusMark;
    //
    const userExam = {};
    userExam.userId = body.userId;
    userExam.examId = exam.id;
    userExam.startTime = body.startTime;
    userExam.endTime = body.endTime;
    userExam.status = body.status;
    userExam.questionsAnswered = questionsAnswered;
    userExam.correctAnswers = correctAnswers;
    userExam.wrongAnswers = wrongAnswers;
    userExam.score = score;
    //
    const nUserExam = await createUserExam(userExam);
    //
    const insertedQus = await createExamQuestions(nUserExam.id, questions);

    res.json(nUserExam);
    //
  } catch (error) {
    res.json({ error: error.message });
  }
};
