const express = require('express');
const { 
    createOrder, 
    getAllOrders,
    deleteOrder,
    getDetailOrder,
    updateOrder,
    updateStatusOrder, 
} = require('../controllers/orderController');

const route = express.Router();


route.get('/layDanhSachDonHang', getAllOrders);
route.get('/chiTietDonHang', getDetailOrder);
route.post('/themDonHang', createOrder);
route.put('/capNhatTrangThaiDonHang', updateStatusOrder);
route.delete('/xoaDonHang', deleteOrder);

module.exports = route;