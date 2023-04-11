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
    deleteSubCategory
} = require('../controllers/categoriesController');
const route = express.Router();


route.get('/layDanhMuc', getAllCategories);
route.get('/chiTietDanhMuc', getACategories);
route.post('/themDanhMuc', createCategories);
route.put('/capNhatDanhMuc', updateCategories );
route.delete('/xoaDanhMuc', deleteCategories);


route.get('/layDanhMucNho', getAllSubCategory);
route.get('/chiTietDanhMucNho', getASubCategory);
route.post('/themDanhMucNho', createSubCategory);
route.put('/capNhatDanhMucNho', updateSubCategory);
route.delete('/xoaDanhMucNho', deleteSubCategory);



module.exports = route;

