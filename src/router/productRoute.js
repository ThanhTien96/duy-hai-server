const express = require("express");
const {

    createProduct,
    getAllProducts,
    deleteProduct,
    updateProduct,
    getDetailProduct,
    getProductPerPage

} = require("../controllers/productController");

const route = express.Router();
const upload = require("../../middleware/upload");
const { checkValid } = require("../../middleware/productMiddleware");



route.get('/layDanhSachSanPham', getAllProducts);
route.get('/layChiTietSanPham', getDetailProduct);
route.get('/laySanPhamPhanTrang', getProductPerPage);
route.put('/capNhatSanPham', checkValid, upload.array('hinhAnh', 6) ,updateProduct);
route.post('/themSanPham', upload.array('hinhAnh', 6), createProduct);
route.delete('/xoaSanPham', deleteProduct);

module.exports = route;