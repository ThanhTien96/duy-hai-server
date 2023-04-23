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
const { uploadLogo } = require('../middleware/upload');

const router = express.Router();

router.get('/menu', getMenu);
router.post('/taoMenu', uploadLogo.single('logo') ,createMenu);
router.put('/capNhatMenu',uploadLogo.single('logo'), updateMenu);
router.delete('/xoaMenu', deleteMenu);

///////////////////////////////////////////////////////////////
/////////////////// Nav Link Route ////////////////////////////
///////////////////////////////////////////////////////////////

router.get('/navLink', getAllNavLink);
router.post('/taoNavLink', createNavLink);
router.put('/suaNavLink', updateNavLink);
router.delete('/xoaNavLink', deleteNavLink);


module.exports = router;