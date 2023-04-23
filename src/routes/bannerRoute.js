const express = require('express');
const { 
    createBanner, 
    updateBanner, 
    deleteBanner,
    getAllBanner,
} = require('../controllers/bannerController');
const { uploadBanner } = require('../middleware/upload');



const router = express.Router();





router.get('/layDanhSachBanner', getAllBanner);
router.post('/themBanner',uploadBanner.single("hinhAnh") ,createBanner);
router.put('/capNhatBanner', uploadBanner.single("hinhAnh"),updateBanner);
router.delete('/xoaBanner', deleteBanner);


module.exports = router;