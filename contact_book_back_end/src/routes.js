const express = require('express');

const UserController = require('./controllers/UserController');
const ContactController = require('./controllers/ContactController');
const AddressController = require('./controllers/AddressController');
const GroupController = require('./controllers/GroupController');

const authMiddleware = require('./middlewares/auth');

const router = express.Router();

// Only login and create a new user is possible without an authentication
router.post('/users', UserController.createUser);
router.post('/users/login', UserController.login);

// After this, all routes needs authentication 
// router.use(authMiddleware);

// USERS routes services
router.get('/users', UserController.getAllUsers);
router.get('/users/:user_id', UserController.getUser);
router.put('/users/:user_id', UserController.updateUser);
router.delete('/users/:user_id', UserController.deleteUser);

// CONTACTS routes services
router.get('/contacts/:contact_id', ContactController.getContact);
router.get('/users/:user_id/contacts', ContactController.getAllContactsByUserId);
router.post('/users/:user_id/contacts', ContactController.createContact);
router.put('/contacts/:contact_id', ContactController.updateContact);
router.delete('/contacts/:contact_id', ContactController.deleteContact);

// ADDRESS routes services
router.get('/address/:address_id', AddressController.getAddress);
router.get('/contacts/:contact_id/address', AddressController.getAllAddressByContactId);
router.post('/contacts/:contact_id/address', AddressController.createAddress);
router.put('/address/:address_id', AddressController.updateAddress);
router.delete('/address/:address_id', AddressController.deleteAddress);

// GROUP routes services
router.get('/groups/:group_id', GroupController.getGroup);
router.post('/users/:user_id/groups', GroupController.createGroup);
router.post('/contacts/:contact_id/groups', GroupController.addContactToGroup);
router.delete('/contacts/:contact_id/groups', GroupController.deleteContactFromGroup);
router.delete('/groups/:group_id', GroupController.deleteGroup);

module.exports = router;