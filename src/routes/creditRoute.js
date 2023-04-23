const express = require('express');
const { getAllCredit, getDetailCredit, createCredit, updateCredit, deleteCredit } = require('../controllers/creditController');

const route = express.Router();

route.get('/layDanhSachThanhToan', getAllCredit);
route.get('/chiTietThanhToan', getDetailCredit);
route.post('/themThanhToan', createCredit);
route.put('/capNhatThanhToan', updateCredit);
route.delete('/xoaThanhToan', deleteCredit);



module.exports = route;