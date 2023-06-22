const Joi = require('@hapi/joi');

const unitValidation = (data) => {
  const schema = {
    name: Joi.string()
      .regex(/^[a-zA-Z0-9 ]*$/)
      .min(3)
      .max(100)
      .required(),
    content: Joi.string().required(),
    chapterId: Joi.number()
      .integer()
      .required(),
  };
  return Joi.validate(data, schema);
};

const updateUnitValidation = (data) => {
  const schema = {
    id: Joi.number()
      .integer()
      .required(),
    name: Joi.string()
      .regex(/^[a-zA-Z0-9 ]*$/)
      .min(3)
      .max(100)
      .required(),
    content: Joi.string().required(),
  };
  return Joi.validate(data, schema);
};

module.exports.unitValidation = unitValidation;
module.exports.updateUnitValidation = updateUnitValidation;
