const express = require('express');
const { 
    getAllCategories, 
    createCategories, 
    updateCategories, 
    deleteCategories,
    createSubCategory,
    getACategories,
    getAllSubCategory,
    getASubCategory,
    updateSubCategory,
    deleteSubCategory,
    getProductWithSubCategory,
    getProductWithMainCategory
} = require('../controllers/categoriesController');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');
const route = express.Router();


route.get('/layDanhMuc', checkAccessToken, getAllCategories);
route.get('/chiTietDanhMuc',checkAccessToken, getACategories);
route.post('/themDanhMuc',checkAccessToken,isAdmin, createCategories);
route.put('/capNhatDanhMuc',checkAccessToken, isAdmin, updateCategories );
route.delete('/xoaDanhMuc', checkAccessToken, isAdmin, deleteCategories);


route.get('/layDanhMucNho', checkAccessToken, getAllSubCategory);
route.get('/chiTietDanhMucNho', checkAccessToken, getASubCategory);
route.post('/themDanhMucNho', checkAccessToken,isAdmin, createSubCategory);
route.put('/capNhatDanhMucNho', checkAccessToken, isAdmin, updateSubCategory);
route.delete('/xoaDanhMucNho', checkAccessToken, isAdmin, deleteSubCategory);

/** lay san pham theo danh muc chinh */
route.get('/laySanPhamTheoDanhMuchChinh', checkAccessToken, getProductWithMainCategory);
/** lay san pham theo danh muc nho */
route.get('/laySanPhamTheoDanhMucNho',checkAccessToken, getProductWithSubCategory);



module.exports = route;

