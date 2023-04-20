const express = require('express');
const { 

    createPost, 
    getAllPost, 
    getDetailPost, 
    updatePost, 
    deletePost

} = require('../controllers/fixPostController');
const uploadFixPost = require('../../middleware/uploadFixPost');
const route = express.Router();



route.get('/layDanhSachBVSuaChua', getAllPost);
route.get('/layChiTietBVSuaChua', getDetailPost);
route.post('/themBVSuaChua', uploadFixPost.array('hinhAnh', 4) ,createPost);
route.put('/capNhatBVSuaChua', uploadFixPost.array('hinhAnh', 4),updatePost);
route.delete('/xoaBVSuaChua', deletePost);

module.exports = route;
