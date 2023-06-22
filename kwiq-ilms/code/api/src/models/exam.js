module.exports = function question(sequelize, DataTypes) {
  const Exam = sequelize.define('exams', {
    name: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    description: {
      type: DataTypes.STRING,
    },
    image: {
      type: DataTypes.STRING,
    },
    noOfQues: {
      type: DataTypes.INTEGER,
    },
    markPerQue: {
      type: DataTypes.INTEGER,
    },
    negativeMarkPerQue: {
      type: DataTypes.INTEGER,
    },
    durationInMins: {
      type: DataTypes.INTEGER,
    },
    isActive: {
      type: DataTypes.BOOLEAN,
    },
  });

  return Exam;
};
