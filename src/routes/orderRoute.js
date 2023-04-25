const express = require('express');
const { 
    createOrder, 
    getAllOrders,
    deleteOrder,
    getDetailOrder,
    updateOrder,
    updateStatusOrder,
    updatePriorityOrder, 
} = require('../controllers/orderController');

const route = express.Router();


route.get('/layDanhSachDonHang', getAllOrders);
route.get('/chiTietDonHang', getDetailOrder);
route.post('/themDonHang', createOrder);
route.post('/capNhatTrangThaiDonHang', updateStatusOrder);
route.post('/capNhatDoUuTienDonHang', updatePriorityOrder);
route.delete('/xoaDonHang', deleteOrder);

module.exports = route;