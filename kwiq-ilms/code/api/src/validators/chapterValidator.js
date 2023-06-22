const Joi = require('@hapi/joi');

const chapterValidation = (data) => {
  const schema = {
    name: Joi.string()
      .regex(/^[a-zA-Z0-9 ]*$/)
      .min(3)
      .max(100)
      .required(),
    description: Joi.string()
      .regex(/^[a-zA-Z0-9 ]*$/)
      .min(3)
      .max(255)
      .required(),
    subjectId: Joi.number().integer().required(),
  };
  return Joi.validate(data, schema);
};

const updateChapterValidation = (data) => {
  const schema = {
    id: Joi.number().integer().required(),
    description: Joi.string()
      .regex(/^[a-zA-Z0-9 ]*$/)
      .min(3)
      .max(255)
      .required(),
  };
  return Joi.validate(data, schema);
};

module.exports.chapterValidation = chapterValidation;
module.exports.updateChapterValidation = updateChapterValidation;
