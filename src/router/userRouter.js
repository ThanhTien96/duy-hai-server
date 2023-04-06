const express = require('express');
const { 
    getAllUserType, 
    getAUserType, 
    createUserType, 
    updateUserType, 
    deleteUserType, 
    getAllUser, 
    getAUser,
    createUser,
    updateUser,
    deleteUser
} = require('../controllers/userController');
const upload = require('../../middleware/upload');
const router = express.Router();

router.get('/layDanhSachNguoiDung', getAllUser);
router.get('/layNguoiDung', getAUser);
router.post('/themNguoiDung',upload.single("hinhAnh"), createUser);
router.put('/capNhatNguoiDung',upload.single("hinhAnh"), updateUser);
router.delete('/xoaNguoiDung', deleteUser);


  ////////////////////////////////////////
 ///////      USER TYPE         /////////               
////////////////////////////////////////

router.get('/layLoaiNguoiDung', getAllUserType);
router.get('/layMotLoaiNguoiDung', getAUserType);
router.post('/themLoaiNguoiDung', createUserType);
router.put('/capNhatLoaiNguoiDung', updateUserType);
router.delete('/xoaLoaiNguoiDung', deleteUserType);


module.exports = router;