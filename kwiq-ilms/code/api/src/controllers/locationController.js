const models = require('../setup/models');

module.exports.getLocation = async function getLocation(req, res) {
  try {
    const location = await models.Location.findOne({
      attributes: ['id', 'vehicleNumber', 'latitude', 'longitude', 'speed', 'time'],
      where: {
        vehicleNumber: req.params.vehicleNumber,
      },
    });
    res.json(location);
  } catch (error) {
    res.json({ message: error });
  }
};

module.exports.updateOrCreate = async function updateOrCreate(req, res) {
  try {
    const { body } = req;
    // console.log(JSON.stringify(body));
    const location = await models.Location.findOne({
      where: {
        vehicleNumber: body.vehicleNumber,
      },
    });
    if (!location) {
      const item = await models.Location.create({
        vehicleNumber: body.vehicleNumber,
        latitude: body.latitude,
        longitude: body.longitude,
        speed: body.speed,
        time: body.time,
      });
      res.json(item);
    } else {
      const updatedLocation = await models.Location.update(
        {
          vehicleNumber: body.vehicleNumber,
          latitude: body.latitude,
          longitude: body.longitude,
          speed: body.speed,
          time: body.time,
        },
        {
          where: { vehicleNumber: body.vehicleNumber },
        },
      );
      res.json(updatedLocation);
    }
  } catch (error) {
    // console.log(error.message);
    res.json({ message: error });
  }
};
