
const express = require('express');
const { uploadAboutImage } = require('../middleware/upload');
const { 
    createContent, 
    getAllContent,
    getDetailContent,
    updateContent,
    deleteContent, 
} = require('../controllers/aboutPageController');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');
const route = express.Router();

route.get('/layNoiDungGioiThieu', checkAccessToken,getAllContent);
route.get('/chiTietNoiDungGioiThieu', checkAccessToken,getDetailContent);
route.post('/themNoiDungGioiThieu',checkAccessToken, isAdmin,uploadAboutImage.array('hinhAnh', 4), createContent);
route.put('/capNhatNoiDungGioiThieu',checkAccessToken, isAdmin, uploadAboutImage.array('hinhAnh', 4), updateContent);
route.delete('/xoaNoiDungGioiThieu', checkAccessToken, isAdmin,deleteContent);

module.exports = route;