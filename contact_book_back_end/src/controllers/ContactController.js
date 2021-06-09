const User = require('../models/User');
const Contact = require('../models/Contact');

module.exports = {
  //############## GET ##############
  async getContact(req, res) {
    const {user_id} = req.params;

    const user = await User.findByPk(user_id, {include: {association: 'contact'}});

    if (!user)
      return res.status(400).send({status: false, message: 'User not found!'});

    return res.status(200).send(user);
  },

  async getAllContacts(req, res) {
    const {user_id} = req.params;

    const user = await User.findByPk(user_id, {include: {association: 'contact'}});

    if (!user)
      return res.status(400).send({status: false, message: 'User not found!'});

    return res.status(200).send(user);
  },

  //############## POST ##############
  async createContact(req, res) {
    try {
      const {user_id} = req.params;
      const {name} = req.body;
      const user = await User.findByPk(user_id);
      
      if (!user)
        return res.status(400).json({status: 0, message: 'User not found!'});
  
      const contact = await Contact.create({name, user_id,});

      return res.status(200).json({
        status: true,
        message: "Contact registered successfully!",
        contact
      });
    } 
    catch (e) {
      return res.status(400).json({error: e});
    }
  },

  //############## PUT ##############
  async updateContact(req, res) {
    const id = req.params.contact_id;
    const {name} = req.body;

    try {
      const contact = await Contact.findByPk(id);

      if (contact) {
        await Contact.update({name}, {where: {id}});

        return res.status(200).json({
          status: true,
          message: "Contact successfully updated!",
        });

      } else {
        return res.status(400).json({status: false, message: 'Contact not found!'});
      }

    } catch (e) {
      return res.status(400).json({status: false, message: 'Error updating contact!'});
    }
  },

  //############## DELETE ##############
  async deleteContact(req, res) {
    const id = req.params.contact_id;

    try {
      const contact = await Contact.findByPk(id);

      if (contact) {
        await Contact.destroy({where: {id}});

        return res.status(200).json({
          status: true,
          message: "Contact successfully deleted!",
        });

      } else {
        return res.status(400).json({
          status: false,
          message: 'Contact not found!'
        });
      }

    } catch (e) {
      return res.status(400).json({error: e});
    }
  }
};