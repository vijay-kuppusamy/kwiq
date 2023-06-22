module.exports = function subject(sequelize, DataTypes) {
  const Subject = sequelize.define('subjects', {
    name: {
      type: DataTypes.STRING,
    },
    description: {
      type: DataTypes.STRING,
    },
    image: {
      type: DataTypes.STRING,
    },
    courseId: {
      type: DataTypes.INTEGER,
    },
  });

  Subject.associate = function asso(models) {
    Subject.belongsTo(models.Course);
    Subject.hasMany(models.Chapter);
  };

  return Subject;
};
