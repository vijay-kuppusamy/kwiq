const Joi = require('@hapi/joi');

// Password Pattern
// Password matching expression.
// six to ten characters, at least one uppercase letter, one lowercase letter and one number

const registrationValidation = (data) => {
  const schema = {
    username: Joi.string()
      .regex(/^[a-zA-Z0-9 ]*$/)
      .min(3)
      .max(30)
      .required(),
    email: Joi.string().email({ minDomainSegments: 2 }),
  };
  return Joi.validate(data, schema);
};

const loginValidation = (data) => {
  const schema = {
    email: Joi.string()
      .email({ minDomainSegments: 2 })
      .required(),
    password: Joi.string()
      .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,10}$/)
      .min(6)
      .max(10)
      .required(),
    userRole: Joi.string(),
  };
  return Joi.validate(data, schema);
};

const updateValidation = (data) => {
  const schema = {
    username: Joi.string()
      .regex(/^[a-zA-Z0-9 ]*$/)
      .min(3)
      .max(30),
    email: Joi.string()
      .email({ minDomainSegments: 2 })
      .required(),
    password: Joi.string()
      .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,10}$/)
      .min(6)
      .max(10)
      .required(),
    newPassword: Joi.string()
      .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,10}$/)
      .min(6)
      .max(10)
      .required(),
  };
  return Joi.validate(data, schema);
};

const resetValidation = (data) => {
  const schema = {
    email: Joi.string()
      .email({ minDomainSegments: 2 })
      .required(),
  };
  return Joi.validate(data, schema);
};

module.exports.registrationValidation = registrationValidation;
module.exports.loginValidation = loginValidation;
module.exports.updateValidation = updateValidation;
module.exports.resetValidation = resetValidation;
