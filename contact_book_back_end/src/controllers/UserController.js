const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const authConfig = require('../config/auth')

function generateToken(params = {}) {
  return jwt.sign(params, authConfig.secret, {
    // Token expira em 24h
    expiresIn: 86400,
  });
}

module.exports = {
  async login(req, res) {
    const {password, email} = req.body;
    const user = await User.findOne({where: {email}});

    if (!user) {
      return res.status(400).send({
        status: 0,
        message: 'Incorrect email or password!',
        user: {}
      });
    }

    if (!bcrypt.compareSync(password, user.password)) {
      return res.status(400).send({
        status: 0,
        message: 'Incorrect email or password!',
        user: {}
      });
    }

    user.password = undefined
    const token = generateToken({id: user.id});

    return res.status(200).send({
      status: 1,
      message: "User successfully logged in!",
      user, 
      token
    });
  },
  async index(req, res) {
    const users = await User.findAll();

    if (users == "" || users == null) {
      return res.status(200).send({message: "No registered users!"});
    }
    return res.status(200).send({users});
  },
  async store(req, res) {
    const {name, password, email} = req.body;
    const user = await User.create({name, password, email});

    user.password = undefined

    return res.status(200).send({
      status: 1,
      message: 'Successfully registered user!',
      user
    });
  },
  async update(req, res) {
    const {name, password, email} = req.body;
    const {user_id} = req.params;

    await User.update({name, password, email}, {where: {id: user_id}});

    return res.status(200).send({
      status: 1,
      message: "User updated successfully!",
    });
  },
  async delete(req, res) {
    const {user_id} = req.params;

    await User.destroy({where: {id: user_id}});

    return res.status(200).send({
      status: 1,
      message: "User deleted successfully!",
    });
  }
};