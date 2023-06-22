module.exports = function question(sequelize, DataTypes) {
  const Location = sequelize.define('location', {
    vehicleNumber: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    latitude: {
      type: DataTypes.DOUBLE,
      allowNull: false,
    },
    longitude: {
      type: DataTypes.DOUBLE,
      allowNull: false,
    },
    speed: {
      type: DataTypes.DOUBLE,
      allowNull: false,
    },
    time: {
      type: DataTypes.DOUBLE,
      allowNull: false,
    },
  });

  return Location;
};
