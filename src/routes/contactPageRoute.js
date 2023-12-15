const express = require('express');
const { getAllContactPage, getAContactPage, createContactPage, updateContactPage, deleteContactPage } = require('../controllers/contactPageController');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');

const route = express.Router();

route.get('/contactPages', checkAccessToken, getAllContactPage);
route.get('/contactPage',checkAccessToken, getAContactPage);
route.post('/createContactPage', checkAccessToken, isAdmin, createContactPage);
route.put('/updateContactPage', checkAccessToken, isAdmin, updateContactPage);
route.delete('/deleteContactPage', checkAccessToken, isAdmin, deleteContactPage);

module.exports = route;