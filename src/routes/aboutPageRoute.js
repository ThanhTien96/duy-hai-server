
const express = require('express');
const { uploadAboutImage } = require('../middleware/upload');
const { 
    createContent, 
    getAllContent,
    getDetailContent,
    updateContent,
    deleteContent, 
} = require('../controllers/aboutPageController');
const route = express.Router();

route.get('/layNoiDungGioiThieu', getAllContent);
route.get('/chiTietNoiDungGioiThieu', getDetailContent);
route.post('/themNoiDungGioiThieu',uploadAboutImage.array('hinhAnh', 4), createContent);
route.put('/capNhatNoiDungGioiThieu', uploadAboutImage.array('hinhAnh', 4), updateContent);
route.delete('/xoaNoiDungGioiThieu', deleteContent);

module.exports = route;