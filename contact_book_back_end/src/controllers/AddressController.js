const Contact = require('../models/Contact');
const Address = require('../models/Address');

module.exports = {
  //############## GET ##############
  async getAddress(req, res) {
    const {address_id} = req.params;

    try {
      const address = await Address.findByPk(address_id);

      if (!address)
        return res.status(400).send({status: false, message: 'Address not found!'});

      return res.status(200).send(address);

    } catch (e) {
      return res.status(400).json({
        status: false,  
        message: 'Error getting address!',
        error: e
      });
    }
  },

  async getAllAddressByContactId(req, res) {
    const { contact_id } = req.params;

    try {
      const contact = await Contact.findByPk(contact_id, {include: {association: 'address'}});

      if (!contact)
        return res.status(400).send({status: false, message: 'Contact not found!'});
          
      return res.status(200).send(contact);

    } catch (e) {
      return res.status(400).json({
        status: false,  
        message: 'Error getting all address!',
        error: e
      });
    }
  },

  //############## POST ##############
  async createAddress(req, res) {
    const {contact_id} = req.params;
    const {phone, email, zip_code, street, number, district, city} = req.body;
    
    try { 
      const contact = await Contact.findByPk(contact_id);

      if (!contact) 
        return res.status(400).json({status: false, message: 'Contact not found!'});
          
      const address = await Address.create({
        phone,
        email,
        zip_code,
        street,
        number,
        district,
        city,
        uf,
        contact_id,
      });

      return res.status(200).json({
        status: true,
        message: "Address registered successfully!",
        address
      });

    } catch (e) {
      return res.status(400).json({
        status: false,  
        message: 'Error creating address!',
        error: e
      });
    }
  },

  //############## PUT ##############
  async updateAddress(req, res) {
    const {address_id} = req.params;
    const {phone, email, zip_code, street, number, district, city} = req.body;

    try {
      const address = await Address.findByPk(address_id);

      if (address) {
        await Address.update({
          phone,
          email, 
          zip_code, 
          street, 
          number, 
          district, 
          city,
          uf
        }, {where: {id: address_id}});

        return res.status(200).json({
          status: true,
          message: "Address successfully updated!",
        });

      } else {
        return res.status(400).json({status: false, message: 'Address not found!'});
      }

    } catch (e) {
      return res.status(400).json({
        status: false,  
        message: 'Error updating address!',
        error: e
      });
    }
  },

  //############## DELETE ##############
  async deleteAddress(req, res) {
    const {address_id} = req.params;

    try {
      const address = await Address.findByPk(address_id);

      if (address) {
        await Address.destroy({where: {id: address_id}});

        return res.status(200).json({
          status: true,
          message: "Address successfully deleted!",
        });

      } else {
        return res.status(400).json({status: false, message: 'Address not found!'});
      }

    } catch (e) {
      return res.status(400).json({
        status: false,  
        message: 'Error deleting address!',
        error: e
      });
    }
  }
};