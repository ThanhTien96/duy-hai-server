const express = require('express');
const { 
    getAllContact, 
    getDetailContact, 
    createContact,  
    deleteContact, 
    createContactStatus, 
    getAllContactStatus,
    getDetailContactStatus,
    updateContactStatus,
    deleteContactStatus,
    updateContactWithStatus
} = require('../controllers/contactController');
const { checkAccessToken, isAdmin} = require('../middleware/authUser')
const route = express.Router();

route.get('/layDanhSachLienHe', checkAccessToken, getAllContact);
route.get('/chiTietLienHe', checkAccessToken, getDetailContact);
route.post('/themLienHe', checkAccessToken, createContact);
route.put('/capNhatTrangThaiLienHe', checkAccessToken, isAdmin, updateContactWithStatus);
route.delete('/xoaLienHe', checkAccessToken, isAdmin, deleteContact);


route.get('/trangThaiLienHe', checkAccessToken,getAllContactStatus)
route.get('/chiTieTrangThaiLienHe', checkAccessToken,getDetailContactStatus)
route.post('/themTrangThaiLienHe', checkAccessToken, isAdmin,createContactStatus)
route.put('/capNhatTrangThaiLienHe', checkAccessToken, isAdmin,updateContactStatus)
route.delete('/xoaTrangThaiLienHe', checkAccessToken, isAdmin,deleteContactStatus)

module.exports = route;



