const express = require('express');
const { 
    createComment, getAllComment, getDetailComment, updateComment, deleteComment, getCommentWithProduct,

} = require('../controllers/commentControler');

const route = express.Router();


route.get('/layBinhLuan', getAllComment);
route.get('/chiTietBinhLuan', getDetailComment);
route.get('/layBinhLuanTheoSanPham', getCommentWithProduct)
route.post('/themBinhLuan', createComment);
route.put('/capNhatBinhLuan', updateComment);
route.delete('/xoaBinhLuan', deleteComment);


module.exports = route;