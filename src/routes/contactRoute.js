const express = require('express');
const { getAllContact, getDetailContact, createContact, updateContact, deleteContact } = require('../controllers/contactController');

const route = express.Router();

route.get('/layDanhSachLienHe', getAllContact);
route.get('/chiTietLienHe', getDetailContact);
route.post('/themLienHe', createContact);
route.put('/capNhatLienHe', updateContact);
route.delete('/xoaLienHe', deleteContact);

module.exports = route;
