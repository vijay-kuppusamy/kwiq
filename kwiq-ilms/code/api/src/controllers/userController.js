const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const RandExp = require('randexp');
const Joi = require('@hapi/joi');

const models = require('../setup/models');
const mailer = require('../middlewares/mailer');
const { JWT_SEC } = require('../config/env');

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

function generatePasskey() {
  const randExp = new RandExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,10}$/);
  let validated = false;
  let key = '';
  while (!validated) {
    key = randExp.gen();
    if (keyValidation({ key }) && hasNumber(key)) {
      validated = true;
    }
  }
  return key;
}

module.exports.findAllUsers = function findAllUsers(req, res) {
  try {
    models.User.findAll()
      .then((users) => {
        res.json(users);
      })
      .catch((err) => {
        res.json({ message: err });
      });
  } catch (err) {
    res.json({ message: err });
  }
};

module.exports.findById = async function findById(req, res) {
  try {
    const users = await models.User.findOne({
      where: {
        id: req.params.id,
      },
    });
    res.json(users);
  } catch (err) {
    res.json({ message: err });
  }
};

module.exports.loginUser = async function loginUser(req, res) {
  try {
    const { body } = req;

    const user = await models.User.findOne({
      where: {
        email: body.email,
      },
    }).catch(() => {
      // res.json({ error: error.message });
      // console.log(error.message);
    });

    if (user) {
      const validated = bcrypt.compareSync(body.password, user.password);
      if (validated) {
        const token = jwt.sign({ id: user.id, role: user.role }, JWT_SEC);
        const userDetails = {};
        userDetails.id = user.id;
        userDetails.name = user.username;
        userDetails.email = user.email;
        userDetails.token = token;

        // Admin user login
        if (body.userRole && body.userRole === 'admin' && body.userRole !== user.role) {
          res.json({ error: 'Access Denied' });
        } else {
          res.json(userDetails);
        }
      } else {
        res.json({ error: 'email or password is not correct' });
      }
    } else {
      res.json({ error: 'user is not registered' });
    }
  } catch (err) {
    res.json({ error: err.message });
  }
};

async function sendWelcomeMail(username, toAddress, password) {
  const sub = 'Welcome...';
  const htmlMsg = `<p>Dear <b>${username} ,</b><br><br>Welcome to Kwiq Academy.<br><br>Your generated login password is ${password} <br> You can change your password after your first login. <br><br> Thanks, <br>Admin</p>`;
  const info = await mailer.sendMail(toAddress, sub, htmlMsg);
  return info;
}

async function sendResetMail(toAddress, password) {
  const sub = 'Account Reset';
  const htmlMsg = `<p>Dear <b>${toAddress}</b><br><br>Your account reset request has been completed.<br>Your generated login password is ${password} <br> You can change your password after your login. <br><br> Thanks, <br>Admin</p>`;
  const info = await mailer.sendMail(toAddress, sub, htmlMsg);
  return info;
}

module.exports.saveUser = async function saveUser(req, res) {
  const { body } = req;
  const { username, email } = body;
  try {
    const userExists = await models.User.findOne({
      where: {
        email,
      },
    });

    if (!userExists) {
      const password = generatePasskey();
      const salt = bcrypt.genSaltSync(10);
      const hash = bcrypt.hashSync(password, salt);

      await models.User.create({
        username,
        password: hash,
        email,
        role: 'user',
      });

      const mailInfo = await sendWelcomeMail(username, email, password);

      res.json({
        message: 'Your account has been created. Please check your mail for login credential',
      });
    } else {
      res.json({ error: 'Email already registered' });
    }
  } catch (err) {
    res.json({ error: err.message });
  }
};

module.exports.updateUser = async function updateUser(req, res) {
  //
  const { body } = req;
  try {
    const user = await models.User.findOne({
      where: {
        email: body.email,
      },
    }).catch(() => {
      // res.json({ error: error.message });
      // console.log(error.message);
    });

    if (user) {
      const validated = bcrypt.compareSync(body.password, user.password);
      if (validated) {
        //
        const salt = bcrypt.genSaltSync(10);
        const hash = bcrypt.hashSync(body.newPassword, salt);

        const updatedUser = await models.User.update(
          {
            username: body.username,
            password: hash,
          },
          {
            where: {
              email: body.email,
            },
          },
        );
      } else {
        res.json({ error: 'email or password is not correct' });
      }
    } else {
      res.json({ error: 'user is not registered' });
    }
    res.json({ message: 'Your account has been updated. Please login to proceed' });
  } catch (err) {
    res.json({ message: err });
  }
};

module.exports.resetUser = async function resetUser(req, res) {
  //
  const { body } = req;
  try {
    const user = await models.User.findOne({
      where: {
        email: body.email,
      },
    }).catch(() => {
      // res.json({ error: error.message });
      // console.log(error.message);
    });

    if (user) {
      //
      const password = generatePasskey();
      const salt = bcrypt.genSaltSync(10);
      const hash = bcrypt.hashSync(password, salt);

      const updatedUser = await models.User.update(
        {
          password: hash,
        },
        {
          where: {
            email: body.email,
          },
        },
      );
      //
      const mailInfo = await sendResetMail(body.email, password);
      //
    } else {
      res.json({ error: 'user is not registered' });
    }
    res.json({
      message: 'Your account has been reset. Please check your mail for login credential',
    });
  } catch (err) {
    res.json({ message: err });
  }
};

module.exports.deleteUser = async function deleteUser(req, res) {
  const { body } = req;
  try {
    const user = await models.User.destroy({
      where: {
        id: body.id,
      },
    });
    res.json(user);
  } catch (err) {
    res.json({ message: err });
  }
};
