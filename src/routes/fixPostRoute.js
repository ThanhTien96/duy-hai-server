const express = require('express');
const { 

    createPost, 
    getAllPost, 
    getDetailPost, 
    updatePost, 
    deletePost

} = require('../controllers/fixPostController');
const { checkAccessToken, isAdmin } = require('../middleware/authUser')
const { uploadFixPost } = require('../middleware/upload');
const route = express.Router();


route.get('/layDanhSachBVSuaChua', checkAccessToken, getAllPost);
route.get('/layChiTietBVSuaChua', checkAccessToken, getDetailPost);
route.post('/themBVSuaChua', checkAccessToken, isAdmin, uploadFixPost.array('hinhAnh', 4) ,createPost);
route.put('/capNhatBVSuaChua', checkAccessToken, isAdmin, uploadFixPost.array('hinhAnh', 4),updatePost);
route.delete('/xoaBVSuaChua', checkAccessToken, isAdmin, deletePost);

module.exports = route;
