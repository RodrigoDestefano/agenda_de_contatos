const express = require('express');

const UserController = require('./controllers/UserController');
const ContactController = require('./controllers/ContactController');

const authMiddleware = require('./middlewares/auth');

const router = express.Router();

router.get('/users', UserController.index);
router.post('/users', UserController.store);
router.put('/users/:user_id', UserController.update);
router.delete('/users/:user_id', UserController.delete);
router.post('/users/login', UserController.login);

router.use(authMiddleware);

router.get('/users/:user_id/contacts', ContactController.index);
router.post('/users/:user_id/contacts', ContactController.store);
router.put('/users/:user_id/contacts/:contact_id', ContactController.update);
router.delete('/users/:user_id/contacts/:contact_id', ContactController.delete);

module.exports = router;