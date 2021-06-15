const User = require('../models/User');
const Contact = require('../models/Contact');

module.exports = {
  //############## GET ##############
  async getContact(req, res) {
    const {contact_id} = req.params;

    try {   
      const contact = await Contact.findByPk(contact_id);

      if (!contact)
        return res.status(400).send({status: false, message: 'Contact not found!'});

      return res.status(200).send(contact);
    
    } catch (error) {
      return res.status(400).json({
        status: false,  
        message: 'Error getting contact!',
        error: error
      });
    }
  },

  async getAllContactsByUserId(req, res) {
    const {user_id} = req.params;

    try {
      const user = await User.findByPk(user_id, {include: {association: 'contact'}});

      if (!user)
        return res.status(400).send({status: false, message: 'User not found!'});

      // Dont show the password in the response
      user.password = undefined

      return res.status(200).send(user);
    
    } catch (error) {
      return res.status(400).json({
        status: false,  
        message: 'Error getting all contacts!',
        error: error
      });
    }
  },

  //############## POST ##############
  async createContact(req, res) {
    const {user_id} = req.params;
    const {name, phone, email, zip_code, street, number, district, city, uf} = req.body;
    
    try {
      const user = await User.findByPk(user_id);
      const named_contact = await User.findOne({where: {name, id: user_id}});
      
      if (!user)
        return res.status(400).json({status: false, message: 'User not found!'});
      
      // Unique verification
      if(named_contact)
        return res.status(400).send({status: false, message: "Contact name already registered!"});
  
      const contact = await Contact.create({
        name,
        phone,
        email,
        zip_code,
        street,
        number,
        district,
        city,
        uf,
        user_id,
        });

      return res.status(200).json({
        status: true,
        message: "Contact registered successfully!",
        contact
      });

    } catch (error) {
      return res.status(400).json({
        status: false,  
        message: 'Error creating contact!',
        error: error
      });
    }
  },

  //############## PUT ##############
  async updateContact(req, res) {
    const {contact_id} = req.params;
    const {name, phone, email, zip_code, street, number, district, city, uf} = req.body;

    try {
      const contact = await Contact.findByPk(contact_id);

      if (contact) {
        await Contact.update({
          name,
          phone,
          email,
          zip_code,
          street,
          number,
          district,
          city,
          uf
        }, {where: {id: contact_id}});

        return res.status(200).json({
          status: true,
          message: "Contact successfully updated!",
        });
      } else {
        return res.status(400).json({status: false, message: 'Contact not found!'});
      }

    } catch (error) {
      return res.status(400).json({
        status: false,  
        message: 'Error updating contact!',
        error: error
      });
    }
  },

  //############## DELETE ##############
  async deleteContact(req, res) {
    const {contact_id} = req.params;

    try {
      const contact = await Contact.findByPk(contact_id);

      if (contact) {
        await Contact.destroy({where: {id: contact_id}});

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

    } catch (error) {
      return res.status(400).json({
        status: false,  
        message: 'Error deleting contact!',
        error: error
      });
    }
  }
};