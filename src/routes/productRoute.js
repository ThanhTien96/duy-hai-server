const express = require("express");
const {
    createProduct,
    getAllProducts,
    deleteProduct,
    updateProduct,
    getDetailProduct,
    getProductPerPage,
    activeProductImage,
    updateImageProduct,

} = require("../controllers/productController");
const { upload } = require("../middleware/upload");
const { checkAccessToken, isAdmin } = require("../middleware/authUser");

const route = express.Router();

//  active image 
route.post('/hinhChinh', checkAccessToken, isAdmin ,activeProductImage);
// update image 
route.put('/capNhatHinhSanPham', checkAccessToken, isAdmin ,upload.single('hinhAnh') ,updateImageProduct);


route.get('/layDanhSachSanPham', getAllProducts);
route.get('/layChiTietSanPham',checkAccessToken , getDetailProduct);
route.get('/laySanPhamPhanTrang', checkAccessToken, getProductPerPage);
route.put('/capNhatSanPham',checkAccessToken, isAdmin, upload.array('hinhAnh', 6) ,updateProduct);
route.post('/themSanPham', checkAccessToken, isAdmin, upload.array('hinhAnh', 6), createProduct);
route.delete('/xoaSanPham', checkAccessToken, isAdmin, deleteProduct);

module.exports = route;