const express = require('express');
const { 
    getALlSpPost, 
    getDetailSpPost, 
    createSpPost,
    updateSpPost,
    deleteSpPost,
    createCommentSpPost,
    getAllCommentSpPost,
} = require('../controllers/supportPostController');
const route = express.Router();


/** support post */

route.get('/layDanhSachBvHoTro', getALlSpPost);
route.get('/ChiTietBvHoTro', getDetailSpPost);
route.post('/themBvHoTro', createSpPost);
route.put('/capNhatBvHoTro', updateSpPost);
route.delete('/xoaBvHoTro', deleteSpPost);


/** comment support content */

route.get('/layBinhLuanBvHoTro', getAllCommentSpPost)
route.post('/binhLuanBvHoTro', createCommentSpPost);

module.exports = route

