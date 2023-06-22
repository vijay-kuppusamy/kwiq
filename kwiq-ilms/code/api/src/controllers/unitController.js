const models = require('../setup/models');

module.exports.getAllUnits = async function getAllUnits(req, res) {
  try {
    const units = await models.Unit.findAll({
      attributes: ['id', 'name', 'videoUrl'],
      where: { chapterId: req.params.chapterId },
    });
    res.json(units);
  } catch (error) {
    res.json({ error });
  }
};

module.exports.getUnit = async function getUnit(req, res) {
  try {
    const unit = await models.Unit.findOne({
      attributes: ['id', 'name', 'videoUrl', 'content'],
      where: {
        id: req.params.id,
      },
    });
    res.json(unit);
  } catch (error) {
    res.json({ message: error });
  }
};

module.exports.createUnit = function createUnit(req, res) {
  try {
    const { body } = req;
    models.Unit.findOrCreate({
      where: { name: body.name, chapterId: body.chapterId },
      defaults: {
        name: body.name,
        videoUrl: body.videoUrl,
        content: body.content,
        chapterId: body.chapterId,
      },
    })
      .then(([unit, created]) => {
        if (created) {
          res.json(unit);
        } else {
          res.json({ message: 'Unit name already exists' });
        }
      })
      .catch((error) => {
        res.json({ error });
      });
  } catch (error) {
    res.json({ error });
  }
};

module.exports.updateUnit = async function updateUnit(req, res) {
  const { body } = req;
  try {
    const unit = await models.Unit.update(
      {
        name: body.name,
        videoUrl: body.videoUrl,
        content: body.content,
      },
      {
        where: {
          id: body.id,
        },
      },
    );

    res.json(unit);
  } catch (error) {
    res.json({ error });
  }
};

module.exports.deleteUnit = async function deleteUnit(req, res) {
  const { body } = req;
  try {
    const unit = await models.Unit.destroy({
      where: {
        id: body.id,
      },
    });
    res.json(unit);
  } catch (error) {
    res.json({ error });
  }
};
