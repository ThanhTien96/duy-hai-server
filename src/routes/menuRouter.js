const express = require('express');

const { 
    getMenu, 
    deleteMenu, 
    getAllNavLink,
    createNavLink,
    deleteNavLink,
    updateNavLink,
    createMenu,
    updateMenu,
    getANavLink,
    getDetailMenu
} = require('../controllers/menuController');
const { uploadLogo } = require('../middleware/upload');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');

const route = express.Router();

route.get('/menu', checkAccessToken, getMenu);
route.get('/chiTietMenu', checkAccessToken , getDetailMenu)
route.post('/taoMenu', checkAccessToken, isAdmin ,uploadLogo.single('logo') ,createMenu);
route.put('/capNhatMenu', checkAccessToken, isAdmin,uploadLogo.single('logo'), updateMenu);
route.delete('/xoaMenu',checkAccessToken, isAdmin ,deleteMenu);

///////////////////////////////////////////////////////////////
/////////////////// Nav Link Route ////////////////////////////
///////////////////////////////////////////////////////////////

route.get('/navLink',checkAccessToken, getAllNavLink);
route.get('/chiTietNavLink', checkAccessToken,getANavLink)
route.post('/taoNavLink',checkAccessToken, isAdmin, createNavLink);
route.put('/suaNavLink', checkAccessToken, isAdmin, updateNavLink);
route.delete('/xoaNavLink', checkAccessToken, isAdmin, deleteNavLink);


module.exports = route;