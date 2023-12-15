const express = require('express');
const { 
    getAllPriority, 
    createPriority,
    getDetailPriority,
    updatePriority,
    deletePriority,

} = require('../controllers/priorityController');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');

const route = express.Router();



route.get('/layDanhSachDoUuTien', checkAccessToken, getAllPriority);
route.get('/chiTietDoUuTien', checkAccessToken, getDetailPriority);
route.post('/themDoUuTien', checkAccessToken, isAdmin, createPriority);
route.put('/capNhatDoUuTien', checkAccessToken, isAdmin, updatePriority);
route.delete('/xoaDoUuTien', checkAccessToken, isAdmin, deletePriority);



module.exports = route;

