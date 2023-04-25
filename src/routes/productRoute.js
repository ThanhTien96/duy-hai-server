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
const { checkAccessToken, isAdmin } = require("../middleware/authUser");

const route = express.Router();

 


route.get('/layDanhSachSanPham', checkAccessToken, getAllProducts);
route.get('/layChiTietSanPham',checkAccessToken , getDetailProduct);
route.get('/laySanPhamPhanTrang', checkAccessToken, getProductPerPage);
route.put('/capNhatSanPham',checkAccessToken, isAdmin, upload.array('hinhAnh', 6) ,updateProduct);
route.post('/themSanPham', checkAccessToken, isAdmin, upload.array('hinhAnh', 6), createProduct);
route.delete('/xoaSanPham', checkAccessToken, isAdmin, deleteProduct);

module.exports = route;