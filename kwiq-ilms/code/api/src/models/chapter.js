module.exports = function subject(sequelize, DataTypes) {
  const Chapter = sequelize.define('chapters', {
    name: {
      type: DataTypes.STRING,
    },
    description: {
      type: DataTypes.STRING,
    },
    image: {
      type: DataTypes.STRING,
    },
    subjectId: {
      type: DataTypes.INTEGER,
    },
  });

  Chapter.associate = function asso(models) {
    Chapter.belongsTo(models.Subject);
    Chapter.hasMany(models.Unit);
  };

  return Chapter;
};
