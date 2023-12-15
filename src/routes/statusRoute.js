const express = require('express');
const { getAllStatus, createStatus, updateStatus, deleteStatus, getStatusDetail } = require('../controllers/statusController');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');

const route = express.Router();

route.get('/layDanhSachTrangThai', checkAccessToken, getAllStatus);
route.get('/chiTietTrangThai', checkAccessToken, getStatusDetail);
route.post('/themTrangThai', checkAccessToken, isAdmin, createStatus);
route.put('/capNhatTrangThai', checkAccessToken, isAdmin, updateStatus);
route.delete('/xoaTrangThai', checkAccessToken, isAdmin,deleteStatus);


module.exports = route;