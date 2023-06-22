module.exports = function question(sequelize, DataTypes) {
  const Question = sequelize.define('questions', {
    question: {
      type: DataTypes.TEXT,
    },
    optionA: {
      type: DataTypes.TEXT,
    },
    optionB: {
      type: DataTypes.TEXT,
    },
    optionC: {
      type: DataTypes.TEXT,
    },
    optionD: {
      type: DataTypes.TEXT,
    },
    answer: {
      type: DataTypes.TEXT,
    },
    neetQuestionyear: {
      type: DataTypes.INTEGER,
    },
    neetQuestionNo: {
      type: DataTypes.INTEGER,
    },
    isActive: {
      type: DataTypes.BOOLEAN,
    },
    subjectId: {
      type: DataTypes.INTEGER,
    },
    chapterId: {
      type: DataTypes.INTEGER,
    },
  });

  Question.associate = function asso(models) {
    Question.belongsTo(models.Subject);
    Question.belongsTo(models.Chapter);
  };

  return Question;
};
