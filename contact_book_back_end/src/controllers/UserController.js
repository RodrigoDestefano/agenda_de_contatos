const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const authConfig = require('../config/auth');

const { sendEmail } = require('../helpers/email/send_email');

function generateToken(params = {}) {
  return jwt.sign(params, authConfig.secret, {
    // Token ends in 24 hours (86400 seconds)
    expiresIn: 86400,
  });
}

module.exports = {
  //############## GET ##############
  async getAllUsers(req, res) {
    try {
      const users = await User.findAll();

      if (users == "" || users == null)
        return res.status(200).send({message: "No registered users!"});
      
      return res.status(200).send({users});
    
    } catch (error) {
      return res.status(400).json({
        status: false,  
        message: 'Error getting all users!',
        error: error
      });
    }
  },

  async getUser(req, res) {
    const {user_id} = req.params;
    
    try {   
      const user = await User.findByPk(user_id);

      if (!user)
        return res.status(400).send({status: false, message: 'User not found!'});

      // Dont show the password in the response
      user.password = undefined

      return res.status(200).send(user);
    
    } catch (error) {
      return res.status(400).json({
        status: false,  
        message: 'Error getting user!',
        error: error
      });
    }
  },

  //############## POST ##############
  async login(req, res) {
    const {password, email} = req.body;
    
    try {
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
    
    } catch (error) {
      return res.status(400).json({
        status: false,  
        message: 'Login error!',
        error: error
      });
    }
  },

  async createUser(req, res) {
    const {name, password, email} = req.body;

    try {
      const named_user = await User.findOne({where: {email}});

      // Unique verification
      if(named_user)
        return res.status(400).send({status: false, message: "E-mail already registered!"});

      const user = await User.create({name, password, email});
      
      // After creating the user, the email is sent
      sendEmail(user.email, user.name);

      // Dont show the password in the response
      user.password = undefined

      return res.status(200).send({
        status: true,
        message: 'Successfully registered user!',
        user
      });
    
    } catch (error) {
      return res.status(400).json({
        status: false,  
        message: 'Error creating user!',
        error: error
      });
    }
  },

  //############## PUT ##############
  async updateUser(req, res) {
    const {name, password, email} = req.body;
    const {user_id} = req.params;

    try {
      await User.update({name, password, email}, {where: {id: user_id}});

      return res.status(200).send({
        status: true,
        message: "User updated successfully!",
      });
    
    } catch (error) {
      return res.status(400).json({
        status: false,  
        message: 'Error updating user!',
        error: error
      });
    }
  },

  //############## DELETE ##############
  async deleteUser(req, res) {
    const {user_id} = req.params;

    try {
      const user = await User.findByPk(user_id);

      if (user) {
        await User.destroy({where: {id: user_id}});

        return res.status(200).json({
          status: true,
          message: "User successfully deleted!",
        });

      } else {
        return res.status(400).json({
          status: false,
          message: 'User not found!'
        });
      }

    } catch (error) {
      return res.status(400).json({
        status: false,  
        message: 'Error deleting user!',
        error: error
      });
    }
  }
};