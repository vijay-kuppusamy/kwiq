const models = require('../setup/models');

module.exports.getAllCourses = async function getAllCourses(req, res) {
  try {
    const courses = await models.Course.findAll({
      attributes: [
        'id',
        'name',
        'description',
      ],
    });
    res.json(courses);
  } catch (error) {
    res.json({ error });
  }
};

module.exports.getCourse = async function getCourse(req, res) {
  try {
    const course = await models.Course.findOne({
      attributes: [
        'id',
        'name',
        'description',
      ],
      where: {
        name: req.params.name,
      },
    });
    res.json(course);
  } catch (error) {
    res.json({ message: error });
  }
};

module.exports.createCourse = function createCourse(req, res) {
  try {
    const { body } = req;
    models.Course.findOrCreate({
      where: { name: body.name },
      defaults: {
        name: body.name,
        description: body.description,
      },
    }).then(([course, created]) => {
      if (created) {
        res.json(course);
      } else {
        res.json({ message: 'Course name already exists' });
      }
    }).catch((err) => {
      res.json({ message: err });
    });
  } catch (error) {
    res.json({ message: error });
  }
};

module.exports.updateCourse = async function updateCourse(req, res) {
  const { body } = req;
  try {
    const course = await models.Course.update(
      {
        description: body.description,
      },
      {
        where: {
          id: body.id,
          name: body.name,
        },
      },
    );

    res.json(course);
  } catch (err) {
    res.json({ message: err });
  }
};

module.exports.deleteCourse = async function deleteCourse(req, res) {
  const { body } = req;
  try {
    const course = await models.Course.destroy({
      where: {
        id: body.id,
      },
    });
    res.json(course);
  } catch (err) {
    res.json({ message: err });
  }
};
