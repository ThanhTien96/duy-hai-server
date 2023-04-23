const express = require('express');
const { getAllStatus, createStatus, updateStatus, deleteStatus, getStatusDetail } = require('../controllers/statusController');

const route = express.Router();

route.get('/layDanhSachTrangThai', getAllStatus);
route.get('/chiTietTrangThai', getStatusDetail);
route.post('/themTrangThai', createStatus);
route.put('/capNhatTrangThai', updateStatus);
route.delete('/xoaTrangThai',deleteStatus);


module.exports = route;