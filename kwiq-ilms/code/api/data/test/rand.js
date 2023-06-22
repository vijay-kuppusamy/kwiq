const RandExp = require('randexp');
const Joi = require('@hapi/joi');

// six to eight characters, at least one uppercase letter, one lowercase letter and one number

function keyValidation(data) {
  const schema = {
    key: Joi.string()
      .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,10}$/)
      .min(6)
      .max(10)
      .required(),
    userRole: Joi.string(),
  };
  return Joi.validate(data, schema);
}

function hasNumber(myString) {
  return /\d/.test(myString);
}

const randExp = new RandExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,10}$/);

let validated = false;
let key = '';
while (!validated) {
  key = randExp.gen();
  console.log(`key : ${key}`);
  if (keyValidation({ key }) && hasNumber(key)) {
    validated = true;
  }
}
console.log(`validated : ${key}`);
