const express = require('express');
const { getAllYT, getDetailYT, createYT, updateYT, deleteYT } = require('../controllers/youtubeController');
const route = express.Router();
const {uploadYoutube} = require('../middleware/upload');
const { checkAccessToken, isAdmin} = require('../middleware/authUser');


route.get('/layDanhSachYT', checkAccessToken, getAllYT);
route.get('/chiTietYT', checkAccessToken, getDetailYT);
route.post('/themYT', checkAccessToken, isAdmin, uploadYoutube.single('hinhAnh'), createYT);
route.put('/capNhatYT', checkAccessToken, isAdmin, uploadYoutube.single('hinhAnh'), updateYT);
route.delete('/xoaYT', checkAccessToken, isAdmin, deleteYT);

module.exports = route;