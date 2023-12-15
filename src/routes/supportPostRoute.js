const express = require('express');
const { 
    getALlSpPost, 
    getDetailSpPost, 
    createSpPost,
    updateSpPost,
    deleteSpPost,
    createCommentSpPost,
    getAllCommentSpPost,
    getDetailCommentSpPost,
    updateCommentSpPost,
    deleteCommentSpPost,
} = require('../controllers/supportPostController');
const route = express.Router();
const {checkAccessToken, isAdmin} = require('../middleware/authUser')


/** support post */

route.get('/layDanhSachBvHoTro',checkAccessToken, getALlSpPost);
route.get('/ChiTietBvHoTro', checkAccessToken, getDetailSpPost);
route.post('/themBvHoTro', checkAccessToken, isAdmin, createSpPost);
route.put('/capNhatBvHoTro', checkAccessToken, isAdmin, updateSpPost);
route.delete('/xoaBvHoTro', checkAccessToken, isAdmin, deleteSpPost);


/** comment support content */

route.get('/layBinhLuanBvHoTro', checkAccessToken, getAllCommentSpPost);
route.get('/chiTietBinhLuanBvHoTro', checkAccessToken, getDetailCommentSpPost)
route.post('/binhLuanBvHoTro', checkAccessToken, createCommentSpPost);
route.put('/capNhatBinhLuanBvHoTro', checkAccessToken, updateCommentSpPost);
route.delete('/xoaBinhLuanBvHoTro', checkAccessToken, deleteCommentSpPost);


module.exports = route

