const express = require('express');
const { getAllRate, getRateWithProduct, deleteRate, getDetailRate, rateProduct } = require('../controllers/rateController');
const { getDetailComment } = require('../controllers/commentControler');

const route = express.Router();

route.get('/layDanhGia', getAllRate);
route.get('/chiTietDanhGia', getDetailRate);
route.post('/danhGiaSanPham', rateProduct)
route.get('/layDanhGiaTheoSanPham', getRateWithProduct);
route.delete('/xoaDanhGia', deleteRate);


module.exports = route;