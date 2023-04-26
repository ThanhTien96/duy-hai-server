const express = require('express');
const { 
    createOrder, 
    getAllOrders,
    deleteOrder,
    getDetailOrder,
    updateStatusOrder,
    updatePriorityOrder, 
} = require('../controllers/orderController');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');

const route = express.Router();


route.get('/layDanhSachDonHang', checkAccessToken, getAllOrders);
route.get('/chiTietDonHang', checkAccessToken, getDetailOrder);
route.post('/themDonHang',checkAccessToken, isAdmin, createOrder);
route.post('/capNhatTrangThaiDonHang', checkAccessToken, isAdmin, updateStatusOrder);
route.post('/capNhatDoUuTienDonHang', checkAccessToken, isAdmin, updatePriorityOrder);
route.delete('/xoaDonHang', checkAccessToken, isAdmin, deleteOrder);

module.exports = route;