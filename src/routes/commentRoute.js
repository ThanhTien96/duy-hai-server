const express = require('express');
const { 
    createComment, getAllComment, getDetailComment, updateComment, deleteComment, getCommentWithProduct,

} = require('../controllers/commentControler');
const { checkAccessToken, isAdmin } = require('../middleware/authUser')

const route = express.Router();


route.get('/layBinhLuan', checkAccessToken, getAllComment);
route.get('/chiTietBinhLuan', checkAccessToken, getDetailComment);
route.get('/layBinhLuanTheoSanPham', checkAccessToken, getCommentWithProduct)
route.post('/themBinhLuan', checkAccessToken, createComment);
route.put('/capNhatBinhLuan', checkAccessToken, updateComment);
route.delete('/xoaBinhLuan', checkAccessToken, deleteComment);


module.exports = route;