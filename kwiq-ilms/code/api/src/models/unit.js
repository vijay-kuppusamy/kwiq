module.exports = function subject(sequelize, DataTypes) {
  const Unit = sequelize.define('units', {
    name: {
      type: DataTypes.STRING,
    },
    videoUrl: {
      type: DataTypes.STRING,
    },
    content: {
      type: DataTypes.TEXT,
    },
    chapterId: {
      type: DataTypes.INTEGER,
    },
  });

  Unit.associate = function associate(models) {
    Unit.belongsTo(models.Chapter);
  };

  return Unit;
};
