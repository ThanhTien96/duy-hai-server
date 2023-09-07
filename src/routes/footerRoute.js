const express = require('express');
const { footerLinkController, footerController } = require('../controllers/footerController');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');
const route = express.Router();

/** footer link */
route.get('/footerLinks',checkAccessToken, footerLinkController.getAllFooterLink);
route.get('/footerLink',checkAccessToken, footerLinkController.getAFooterLink);
route.post('/createFooterLink',checkAccessToken, isAdmin, footerLinkController.createFooterLink);
route.put('/updateFooterLink',checkAccessToken, isAdmin, footerLinkController.updateFooterLink);
route.delete('/deleteFooterLink',checkAccessToken, isAdmin, footerLinkController.deleteFooterLink);

/** footer route */
route.get('/footers',checkAccessToken, footerController.getAllFooter);
route.get('/footer',checkAccessToken, footerController.getAFooter);
route.post('/createFooter',checkAccessToken, isAdmin, footerController.createFooter);
route.put('/updateFooter',checkAccessToken, isAdmin, footerController.updateFooter);
route.delete('/deleteFooter',checkAccessToken, isAdmin, footerController.deleteFooter);

module.exports = route;