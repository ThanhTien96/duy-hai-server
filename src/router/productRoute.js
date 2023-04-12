const express = require("express");
const {

    createProduct,
    getAllProducts,
    deleteProduct

} = require("../controllers/productController");

const route = express.Router();
const upload = require("../../middleware/upload");



route.get('/layDanhSachSanPham', getAllProducts);
route.put('/capNhatSanPham', upload.array('hinhAnh', 6),);
route.post('/themSanPham', upload.array('hinhAnh', 6), createProduct);
route.delete('/xoaSanPham', deleteProduct);

module.exports = route;