
module.exports = function course(sequelize, DataTypes) {
  const Course = sequelize.define('courses', {
    name: {
      type: DataTypes.STRING,
    },
    description: {
      type: DataTypes.STRING,
    },
  });

  Course.associate = function associate(models) {
    Course.hasMany(models.Subject);
  };

  return Course;
};
