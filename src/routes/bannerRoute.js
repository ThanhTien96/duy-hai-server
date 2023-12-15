const express = require('express');
const { 
    createBanner, 
    updateBanner, 
    deleteBanner,
    getAllBanner,
    getDetailBanner,
} = require('../controllers/bannerController');
const { uploadBanner } = require('../middleware/upload');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');

const router = express.Router();

router.get('/layDanhSachBanner', checkAccessToken, getAllBanner);
router.get('/chiTietBanner', checkAccessToken,getDetailBanner)
router.post('/themBanner',checkAccessToken, isAdmin,uploadBanner.single("hinhAnh") ,createBanner);
router.put('/capNhatBanner', checkAccessToken, isAdmin, uploadBanner.single("hinhAnh"),updateBanner);
router.delete('/xoaBanner', checkAccessToken, isAdmin, deleteBanner);


module.exports = router;