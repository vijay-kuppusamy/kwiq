module.exports = function question(sequelize, DataTypes) {
  const UserExam = sequelize.define('userexams', {
    startTime: {
      type: DataTypes.DATE,
    },
    endTime: {
      type: DataTypes.DATE,
    },
    status: {
      type: DataTypes.STRING,
    },
    score: {
      type: DataTypes.INTEGER,
    },
    questionsAnswered: {
      type: DataTypes.INTEGER,
    },
    correctAnswers: {
      type: DataTypes.INTEGER,
    },
    wrongAnswers: {
      type: DataTypes.INTEGER,
    },
    userId: {
      type: DataTypes.INTEGER,
    },
    examId: {
      type: DataTypes.INTEGER,
    },
  });

  UserExam.associate = function asso(models) {
    UserExam.belongsTo(models.User);
    UserExam.belongsTo(models.Exam);
    UserExam.hasMany(models.ExamQuestion);
  };

  return UserExam;
};
