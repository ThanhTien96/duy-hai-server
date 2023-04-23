const express = require("express");
const {

    createProduct,
    getAllProducts,
    deleteProduct,
    updateProduct,
    getDetailProduct,
    getProductPerPage

} = require("../controllers/productController");
const { upload } = require("../middleware/upload");

const route = express.Router();




route.get('/layDanhSachSanPham', getAllProducts);
route.get('/layChiTietSanPham', getDetailProduct);
route.get('/laySanPhamPhanTrang', getProductPerPage);
route.put('/capNhatSanPham', upload.array('hinhAnh', 6) ,updateProduct);
route.post('/themSanPham', upload.array('hinhAnh', 6), createProduct);
route.delete('/xoaSanPham', deleteProduct);

module.exports = route;