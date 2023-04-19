const express = require('express');
const { getAllRate, getRateWithProduct, createRate, updateRate, deleteRate, getDetailRate } = require('../controllers/rateController');
const { getDetailComment } = require('../controllers/commentControler');

const route = express.Router();

route.get('/layDanhGia', getAllRate);
route.get('/chiTietDanhGia', getDetailRate);
route.get('/layDanhGiaTheoSanPham', getRateWithProduct);
route.post('/themDanhGia', createRate);
route.delete('/xoaDanhGia', deleteRate);


module.exports = route;