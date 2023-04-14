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
    updateNews

} = require('../controllers/newsController');
const uploadNews = require('../../middleware/uploadNews');

const route = express.Router();


route.get('/layTinTuc', getAllNews);
route.get('/chiTietTinTuc', getDetailNews);
route.get('/layTinTucTheoLoai', getAllNews);
route.get('/layTinTucPhanTrang', getAllNews);
route.post('/themTinTuc', uploadNews.array("hinhAnh", 4),createNews);
route.put('/capNhatlayTinTuc', uploadNews.array('hinhAnh', 4), updateNews);
route.delete('/xoaTinTuc', deleteNews);



/****** News Type *******/

route.get('/layLoaiTinTuc', getAllNewsType);
route.get('/chiTietLoaiTinTuc', getDetailNewsType);
route.post('/themLoaiTinTuc', createNewsType);
route.put('/capNhatLoaiTinTuc', updateNewsType);
route.delete('/xoaLoaiTinTuc', deleteNewsType);


module.exports = route;