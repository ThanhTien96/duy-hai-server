const express = require('express');
const { 

    getAllNews, 
    createNewsType, 
    getAllNewsType, 
    getDetailNewsType, 
    updateNewsType, 
    deleteNewsType, 
    createNews,
    getDetailNews,
    deleteNews,
    updateNews,
    getNewWithType,
    getNewPagination

} = require('../controllers/newsController');
const { uploadNews } = require('../middleware/upload');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');


const route = express.Router();


route.get('/layTinTuc', checkAccessToken, getAllNews);
route.get('/chiTietTinTuc',checkAccessToken, getDetailNews);
route.get('/layTinTucTheoLoai', checkAccessToken, getNewWithType);
route.get('/layTinTucPhanTrang', getNewPagination);
route.post('/themTinTuc', checkAccessToken, isAdmin, uploadNews.array("hinhAnh", 4),createNews);
route.put('/capNhatTinTuc', checkAccessToken, isAdmin, uploadNews.array("hinhAnh", 4), updateNews);
route.delete('/xoaTinTuc', checkAccessToken, isAdmin, deleteNews);



/****** News Type *******/

route.get('/layLoaiTinTuc', checkAccessToken, getAllNewsType);
route.get('/chiTietLoaiTinTuc', checkAccessToken, getDetailNewsType);
route.post('/themLoaiTinTuc', checkAccessToken, isAdmin, createNewsType);
route.put('/capNhatLoaiTinTuc', checkAccessToken, isAdmin, updateNewsType);
route.delete('/xoaLoaiTinTuc', checkAccessToken, isAdmin, deleteNewsType);


module.exports = route;