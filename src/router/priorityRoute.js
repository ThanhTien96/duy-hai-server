const express = require('express');
const { 
    getAllPriority, 
    createPriority,
    getDetailPriority,
    updatePriority,
    deletePriority,

} = require('../controllers/priorityController');

const route = express.Router();



route.get('/layDanhSachDoUuTien', getAllPriority);
route.get('/chiTietDoUuTien', getDetailPriority);
route.post('/themDoUuTien', createPriority);
route.put('/capNhatDoUuTien', updatePriority);
route.delete('/xoaDoUuTien', deletePriority);



module.exports = route;

