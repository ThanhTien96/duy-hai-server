const express = require('express');
const { 
    getAllContact, 
    getDetailContact, 
    createContact, 
    updateContact, 
    deleteContact, 
    createContactStatus 
} = require('../controllers/contactController');

const route = express.Router();

route.get('/layDanhSachLienHe', getAllContact);
route.get('/chiTietLienHe', getDetailContact);
route.post('/themLienHe', createContact);
route.put('/capNhatLienHe', updateContact);
route.delete('/xoaLienHe', deleteContact);


route.get('/trangThaiLienHe',)
route.get('/chiTieTrangThaiLienHe',)
route.post('/themTrangThaiLienHe',createContactStatus)
route.put('/capNhatTrangThaiLienHe',)
route.delete('/xoaTrangThaiLienHe',)

module.exports = route;



