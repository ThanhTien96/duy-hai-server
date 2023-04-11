const express = require("express");
const { createProduct, getAllProducts } = require("../controllers/productController");

const route = express.Router();
const upload = require("../../middleware/upload");


route.get('/layDanhSachSanPham', getAllProducts);
route.post('/themSanPham',upload.array('hinhAnh') ,createProduct);

module.exports = route;