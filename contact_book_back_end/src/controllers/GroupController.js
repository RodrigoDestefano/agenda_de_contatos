const Contact = require('../models/Contact');
const Group = require('../models/Group');
const User = require('../models/User');

module.exports = {
  //############## GET ##############
  async getGroup(req, res) {
    const {group_id} = req.params;

    try {
      const group = await Group.findByPk(group_id, {
        include: {association: 'contacts', through: { attributes: ['group_id'] } }
      });

      if (!group) 
        return res.status(400).send({
          status: false,
          message: 'Group not found!'
        });
          
      return res.status(200).send(group);

    } catch (e) {
      return res.status(400).json({
        status: false,  
        message: 'Error getting contacts!',
        error: e
      });
    }
  },

  async getAllGroupsByUserId(req, res) {
    const {user_id} = req.params;

    try {
      const user = await User.findByPk(user_id, {include: {association: 'group'}});

      if (!user)
        return res.status(400).send({status: false, message: 'User not found!'});

      // Dont show the password in the response
      user.password = undefined

      return res.status(200).send(user);
    
    } catch (e) {
      return res.status(400).json({
        status: false,  
        message: 'Error getting all groups!',
        error: e
      });
    }
  },

  //############## POST ##############
  async createGroup(req, res) {
    const {user_id} = req.params;
    const {name} = req.body;

    try {
      const user = await User.findByPk(user_id);
      const named_group = await Group.findOne({where: {name, user_id}});

      if (!user) 
        return res.status(400).json({
          status: false,
          message: 'User not found!'
        });
      
      // Unique verification
      if(named_group)
        return res.status(400).send({status: false, message: "Group name already registered!"});

      const group = await Group.create({name, user_id});

      return res.status(200).json({
        status: true,
        message: "Successfully registered group!",
        group
      });

    } catch (e) {
      return res.status(400).json({
        status: false,  
        message: 'Error creating group!',
        error: e
      });
    }
  },

  async addContactToGroup(req, res) {
    const {contact_id} = req.params;
    const {name} = req.body;

    try {
      const contact = await Contact.findByPk(contact_id);
      const user_id = contact.user_id;

      const group = await Group.findOne({where: {name, user_id}});

      if (!contact) 
        return res.status(400).json({
          status: false,
          message: 'Contact not found!'
        });

      if (!group) 
        return res.status(400).json({
          status: false,
          message: 'Group not found!'
        });     
        
      await contact.addGroup(group);

      return res.status(200).json({
        status: true,
        message: "Successfully added contact to group!"
      });

    } catch (e) {
      return res.status(400).json({
        status: false,  
        message: 'Error creating group!',
        error: e
      });
    }
  },

  //############## DELETE ##############
  async deleteContactFromGroup(req, res) {
    const {contact_id} = req.params;
    const {name} = req.body;
    
    try {
      const contact = await Contact.findByPk(contact_id);
      const user_id = contact.user_id;

      const group = await Group.findOne({where: {name, user_id}});

      if (!contact) 
        return res.status(400).json({
          status: false,
          message: 'Contact not found!'
        });

      if (!group) 
        return res.status(400).json({
          status: false,
          message: 'Group not found!'
        }); 

      await contact.removeGroup(group);

      return res.status(200).json({
        status: true,
        message: "Contact deleted from group!"
      });

    } catch (e) {
      return res.status(400).json({
        status: false,  
        message: 'Error deleting relationship!',
        error: e
      });
    }
  },

  async deleteGroup(req, res) {
    const {group_id} = req.params;

    try {
      const group = await Group.findByPk(group_id);

      if (group) {
        await Group.destroy({where: {id: group_id}});

        return res.status(200).json({
          status: true,
          message: "Group successfully deleted!",
        });

      } else {
        return res.status(400).json({
          status: false,
          message: 'Group not found!'
        });
      }

    } catch (e) {
      return res.status(400).json({
        status: false,  
        message: 'Error deleting group!',
        error: e
      });
    }
  }
};