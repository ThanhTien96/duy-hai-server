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
    deleteUser,
    loginUser,
    registerUser,
    getToken
} = require('../controllers/userController');
const authController = require('../controllers/authController');
const upload = require('../../middleware/upload');
const { authUser } = require('../../middleware/authUser');
const router = express.Router();

router.get('/layDanhSachNguoiDung',authUser ,getAllUser);
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

  ////////////////////////////////////////
 ///////    USER Login logout   /////////               
////////////////////////////////////////

router.post('/dangNhap', loginUser);
router.post('/dangKy', registerUser);
router.post('/layToken', getToken);


module.exports = router;