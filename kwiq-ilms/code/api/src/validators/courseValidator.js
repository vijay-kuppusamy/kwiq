const Joi = require('@hapi/joi');

const courseValidation = (data) => {
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
  };
  return Joi.validate(data, schema);
};

module.exports.courseValidation = courseValidation;
