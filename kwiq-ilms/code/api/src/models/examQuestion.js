module.exports = function question(sequelize, DataTypes) {
  const ExamQuestion = sequelize.define('examquestions', {
    questionId: {
      type: DataTypes.INTEGER,
    },
    userexamId: {
      type: DataTypes.INTEGER,
    },
    userAnswer: {
      type: DataTypes.STRING,
    },
    answer: {
      type: DataTypes.STRING,
    },
  });

  ExamQuestion.associate = function asso(models) {
    ExamQuestion.belongsTo(models.Question);
    ExamQuestion.belongsTo(models.UserExam);
  };

  return ExamQuestion;
};
