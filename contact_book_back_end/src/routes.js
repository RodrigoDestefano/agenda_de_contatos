const express = require('express');

const UserController = require('./controllers/UserController');
const ContactController = require('./controllers/ContactController');

const authMiddleware = require('./middlewares/auth');

const router = express.Router();

// USERS routes services
router.post('/users/login', UserController.login);
router.get('/users', UserController.getAllUsers);
router.post('/users', UserController.createUser);
router.put('/users/:user_id', UserController.updateUser);
router.delete('/users/:user_id', UserController.deleteUser);

// After this, all routes needs authentication 
router.use(authMiddleware);

// CONTACTS routes services
router.get('/users/:user_id/contacts', ContactController.getAllContacts);
router.post('/users/:user_id/contacts', ContactController.createContact);
router.put('/users/contacts/:contact_id', ContactController.updateContact);
router.delete('/users/contacts/:contact_id', ContactController.deleteContact);

module.exports = router;