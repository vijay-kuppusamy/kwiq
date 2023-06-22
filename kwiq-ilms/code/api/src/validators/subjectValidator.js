const Joi = require('@hapi/joi');

const subjectValidation = (data) => {
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
    courseId: Joi.number().integer().required(),
  };
  return Joi.validate(data, schema);
};

const updateSubjectValidation = (data) => {
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

module.exports.subjectValidation = subjectValidation;
module.exports.updateSubjectValidation = updateSubjectValidation;
