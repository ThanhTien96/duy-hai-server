const express = require('express');
const { 
    createBanner, 
    updateBanner, 
    deleteBanner,
    getAllBanner,
} = require('../controllers/bannerController');
const upload = require('../../middleware/upload');


const router = express.Router();


router.get('/layDanhSachBanner', getAllBanner);
router.post('/themBanner',upload.single("hinhAnh") ,createBanner);
router.put('/capNhatBanner', updateBanner);
router.delete('/xoaBanner', deleteBanner);


module.exports = router;