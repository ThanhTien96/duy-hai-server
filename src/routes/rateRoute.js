const express = require('express');
const { getAllRate, getRateWithProduct, deleteRate, getDetailRate, rateProduct } = require('../controllers/rateController');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');


const route = express.Router();

route.get('/layDanhGia', checkAccessToken, getAllRate);
route.get('/chiTietDanhGia', checkAccessToken, getDetailRate);
route.post('/danhGiaSanPham', checkAccessToken, rateProduct)
route.get('/layDanhGiaTheoSanPham', checkAccessToken, getRateWithProduct);
route.delete('/xoaDanhGia',checkAccessToken, isAdmin, deleteRate);


module.exports = route;