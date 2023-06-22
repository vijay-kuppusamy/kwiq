const models = require('../setup/models');

module.exports.getAllChapters = async function getAllChapters(req, res) {
  try {
    const chapters = await models.Chapter.findAll({
      attributes: ['id', 'name', 'image', 'description'],
      where: { subjectId: req.params.subjectId },
    });

    res.json(chapters);
  } catch (error) {
    res.json({ error });
  }
};

module.exports.getChapter = async function getChapter(req, res) {
  try {
    const chapter = await models.Chapter.findOne({
      attributes: ['id', 'name', 'image', 'description'],
      where: {
        name: req.params.name,
        subjectId: req.params.subjectId,
      },
    });
    res.json(chapter);
  } catch (error) {
    res.json({ message: error });
  }
};

module.exports.createChapter = function createChapter(req, res) {
  try {
    const { body } = req;
    models.Chapter.findOrCreate({
      where: { name: body.name, subjectId: body.subjectId },
      defaults: {
        name: body.name,
        description: body.description,
        image: body.image,
        subjectId: body.subjectId,
      },
    })
      .then(([chapter, created]) => {
        if (created) {
          res.json(chapter);
        } else {
          res.json({ message: 'Chapter name already exists' });
        }
      })
      .catch((error) => {
        res.json({ error });
      });
  } catch (error) {
    res.json({ error });
  }
};

module.exports.updateChapter = async function updateChapter(req, res) {
  const { body } = req;
  try {
    const chapter = await models.Chapter.update(
      {
        description: body.description,
      },
      {
        where: {
          id: body.id,
        },
      },
    );

    res.json(chapter);
  } catch (error) {
    res.json({ error });
  }
};

module.exports.deleteChapter = async function deleteChapter(req, res) {
  const { body } = req;
  try {
    const chapter = await models.Chapter.destroy({
      where: {
        id: body.id,
      },
    });
    res.json(chapter);
  } catch (error) {
    res.json({ error });
  }
};
