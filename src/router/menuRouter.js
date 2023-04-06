const express = require('express');

const { 
    getMenu, 
    deleteMenu, 
    getAllNavLink,
    createNavLink,
    deleteNavLink,
    updateNavLink,
    createMenu,
    updateMenu
} = require('../controllers/menuController');

const router = express.Router();

router.get('/menu', getMenu);
router.post('/taoMenu', createMenu);
router.put('/capNhatMenu', updateMenu);
router.delete('/xoaMenu', deleteMenu);

///////////////////////////////////////////////////////////////
/////////////////// Nav Link Route ////////////////////////////
///////////////////////////////////////////////////////////////

router.get('/navLink', getAllNavLink);
router.post('/taoNavLink', createNavLink);
router.put('/suaNavLink', updateNavLink);
router.delete('/xoaNavLink', deleteNavLink);


module.exports = router;