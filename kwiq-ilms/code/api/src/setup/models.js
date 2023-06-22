// Imports
const Sequelize = require('sequelize');
const sequelize = require('../setup/database');

const models = {
  User: sequelize.import('../models/user.js'),
  Course: sequelize.import('../models/course.js'),
  Subject: sequelize.import('../models/subject.js'),
  Chapter: sequelize.import('../models/chapter.js'),
  Unit: sequelize.import('../models/unit.js'),
  Question: sequelize.import('../models/question.js'),
  Exam: sequelize.import('../models/exam.js'),
  UserExam: sequelize.import('../models/userExam.js'),
  ExamQuestion: sequelize.import('../models/examQuestion.js'),
  //
  Location: sequelize.import('../models/location.js'),
};

Object.keys(models).forEach((modelName) => {
  if (models[modelName].associate) {
    models[modelName].associate(models);
  }
});

models.sequelize = sequelize;
models.Sequelize = Sequelize;

module.exports = models;
