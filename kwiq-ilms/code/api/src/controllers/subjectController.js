const models = require('../setup/models');

module.exports.getAllSubjects = async function getAllSubjects(req, res) {
  try {
    const subjects = await models.Subject.findAll({
      attributes: ['id', 'name', 'image', 'description'],
      where: { courseId: req.params.courseId },
    });
    res.json(subjects);
  } catch (error) {
    res.json({ error });
  }
};

module.exports.getSubject = async function getSubject(req, res) {
  try {
    const subject = await models.Subject.findOne({
      attributes: ['id', 'name', 'image', 'description'],
      where: {
        name: req.params.name,
        courseId: req.params.courseId,
      },
    });
    res.json(subject);
  } catch (error) {
    res.json({ message: error });
  }
};

module.exports.createSubject = function createSubject(req, res) {
  try {
    const { body } = req;
    models.Subject.findOrCreate({
      where: { name: body.name, courseId: body.courseId },
      defaults: {
        name: body.name,
        description: body.description,
        image: body.image,
        courseId: body.courseId,
      },
    })
      .then(([subject, created]) => {
        if (created) {
          res.json(subject);
        } else {
          res.json({ message: 'Subject name already exists' });
        }
      })
      .catch((error) => {
        res.json({ error });
      });
  } catch (error) {
    res.json({ error });
  }
};

module.exports.updateSubject = async function updateSubject(req, res) {
  const { body } = req;
  try {
    const subject = await models.Subject.update(
      {
        description: body.description,
      },
      {
        where: {
          id: body.id,
        },
      },
    );

    res.json(subject);
  } catch (error) {
    res.json({ error });
  }
};

module.exports.deleteSubject = async function deleteSubject(req, res) {
  const { body } = req;
  try {
    const subject = await models.Subject.destroy({
      where: {
        id: body.id,
      },
    });
    res.json(subject);
  } catch (error) {
    res.json({ error });
  }
};
