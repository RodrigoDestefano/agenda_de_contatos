const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const authConfig = require('../config/auth')

function generateToken(params = {}) {
  return jwt.sign(params, authConfig.secret, {
    // Token ends in 24 hours (86400 seconds)
    expiresIn: 86400,
  });
}

module.exports = {
  //############## GET ##############
  async getAllUsers(req, res) {
    const users = await User.findAll();

    if (users == "" || users == null)
      return res.status(200).send({message: "No registered users!"});
    
    return res.status(200).send({users});
  },

  //############## POST ##############
  async login(req, res) {
    const {password, email} = req.body;
    const user = await User.findOne({where: {email}});

    if (!user) {
      return res.status(400).send({
        status: false,
        message: 'Incorrect email or password!',
        user: {}
      });
    }

    // Password's verify after hash application
    if (!bcrypt.compareSync(password, user.password)) {
      return res.status(400).send({
        status: false,
        message: 'Incorrect email or password!',
        user: {}
      });
    }

    // Dont show the password in the response
    user.password = undefined
    
    const token = generateToken({id: user.id});

    return res.status(200).send({
      status: true,
      message: "User successfully logged in!",
      user, 
      token
    });
  },

  async createUser(req, res) {
    const {name, password, email} = req.body;
    const userAlreadyRegistered = await User.findOne({where: {email}});

    // UniqueKey verification
    if(userAlreadyRegistered)
      return res.status(400).send({status: false, message: "E-mail already registered!"});

    const user = await User.create({name, password, email});

    // Dont show the password in the response
    user.password = undefined

    return res.status(200).send({
      status: true,
      message: 'Successfully registered user!',
      user
    });
  },

  //############## PUT ##############
  async updateUser(req, res) {
    const {name, password, email} = req.body;
    const {user_id} = req.params;

    await User.update({name, password, email}, {where: {id: user_id}});

    return res.status(200).send({
      status: true,
      message: "User updated successfully!",
    });
  },

  //############## DELETE ##############
  async deleteUser(req, res) {
    const {user_id} = req.params;

    await User.destroy({where: {id: user_id}});

    return res.status(200).send({
      status: true,
      message: "User deleted successfully!",
    });
  }
};