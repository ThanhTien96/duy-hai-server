const express = require('express');
const { 
    getAllCredit, 
    getDetailCredit, 
    createCredit, 
    updateCredit, 
    deleteCredit 
} = require('../controllers/creditController');

const { checkAccessToken, isAdmin } = require('../middleware/authUser');

const route = express.Router();

route.get('/layDanhSachThanhToan', checkAccessToken, getAllCredit);
route.get('/chiTietThanhToan', checkAccessToken, getDetailCredit);
route.post('/themThanhToan', checkAccessToken, isAdmin, createCredit);
route.put('/capNhatThanhToan', checkAccessToken, isAdmin, updateCredit);
route.delete('/xoaThanhToan', checkAccessToken, isAdmin, deleteCredit);



module.exports = route;