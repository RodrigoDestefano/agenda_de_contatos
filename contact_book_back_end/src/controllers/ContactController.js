const User = require('../models/User');
const Contact = require('../models/Contact');

module.exports = {
  //############## GET ALL CONTACTS ##############
  async index(req, res) {
    const {user_id} = req.params;

    const user = await User.findByPk(user_id, {
      include: { association: 'contact'}
    });

    if (!user) {
      return res.status(400).send({
        status: 0,
        message: 'User not found!'
      });
    }

    return res.status(200).send(user);
  },

  //############## POST CONTACT ##############
  async store(req, res) {
    try {
      const {user_id} = req.params;
      const {name} = req.body;
      
      const user = await User.findByPk(user_id);
      
      if (!user) {
        return res.status(400).json({
          status: 0,
          message: 'User not found!'
        });
      }

      const contact = await Contact.create({
        name,
        user_id,
      });

      return res.status(200).json({
        status: 1,
        message: "Contact registered successfully!",
        contact
      });
    } 
    catch (e) {
      return res.status(400).json({error: e});
    }
  },

  //############## DELETE CONTACT ##############
  async delete(req, res) {
    const id = req.params.id;

    try {
      const contact = await Contact.findByPk(id);

      if (contact) {
        await Contact.destroy({where: {id}});

        return res.status(200).json({
          status: 1,
          message: "Contact successfully deleted!",
        });

      } else {
        return res.status(400).json({
          status: 0,
          message: 'Contact not found!'
        });
      }

    } catch (e) {
      return res.status(400).json({error: e});
    }
  },

  //############## PUT CONTACT ##############
  async update(req, res) {
    const id = req.params.id;
    const {name} = req.body;

    try {
      const contact = await Contact.findByPk(id);

      if (contact) {
        await Contact.update({name}, {where: {id}});

        return res.status(200).json({
          status: 1,
          message: "Contact successfully updated!",
        });

      } else {
        return res.status(400).json({
          status: 0,
          message: 'Contact not found!'
        });
      }

    } catch (e) {
      return res.status(400).json({
        status: 0,
        message: 'Error updating contact!'
      });
    }
  }
};