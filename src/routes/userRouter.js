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
    getTokenAccess,
    getUserPagination,
    fetchProfileAccount,
    forgetPassWord,
    getAllOTP,
    checkOtpAndChangePassword,
    changePasswordWithAccount,
    getRefreshToken
} = require('../controllers/userController');
const { uploadAvatar } = require('../middleware/upload');
const { checkAccessToken, isAdmin, authUser } = require('../middleware/authUser');

const router = express.Router();


/** PASSWORD */
router.get('/OTPlist', checkAccessToken, getAllOTP);
router.post('/doiMatKhauOTP', checkAccessToken, checkOtpAndChangePassword);
router.post('/doiMatKhau', checkAccessToken,changePasswordWithAccount)
/** forgot password */
router.post('/quenMatKhau', checkAccessToken, forgetPassWord);

/****** GET TOKEN ACCESS ******/
router.get('/layToken', isAdmin ,getTokenAccess);


router.get('/layChiTietNguoiDung', checkAccessToken,getAUser);
router.get('/layDanhSachNguoiDung',checkAccessToken,getAllUser);
router.get('/layDanhSachNguoiDungPhanTrang', checkAccessToken,getUserPagination);
router.post('/layThongTinTaiKhoan', checkAccessToken, authUser,fetchProfileAccount)
router.post('/themNguoiDung' ,uploadAvatar.single("hinhAnh"), createUser);
router.put('/capNhatNguoiDung', checkAccessToken, isAdmin ,uploadAvatar.single("hinhAnh"), updateUser);
router.delete('/xoaNguoiDung',checkAccessToken,isAdmin,deleteUser);


  ////////////////////////////////////////
 ///////      USER TYPE         /////////               
////////////////////////////////////////

router.get('/layLoaiNguoiDung',getAllUserType);
router.get('/layMotLoaiNguoiDung', checkAccessToken , getAUserType);
router.post('/themLoaiNguoiDung', createUserType);
router.put('/capNhatLoaiNguoiDung',checkAccessToken,isAdmin, updateUserType);
router.delete('/xoaLoaiNguoiDung',checkAccessToken,isAdmin ,deleteUserType);

  ////////////////////////////////////////
 ///////    USER Login logout   /////////               
////////////////////////////////////////

router.post('/dangNhap', loginUser); 
router.post('/dangKy', registerUser);
router.post('/refreshToken', getRefreshToken);


module.exports = router;