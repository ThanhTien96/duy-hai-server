const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const authController = require('./authController');
const fs = require('fs');
require('dotenv').config();


const registerUser = async (req, res) => {
    try {

        
        const { taiKhoan, matKhau, hoTen, soDT, email} = req.body;

        const findTaiKhoan = await prisma.user.findMany({
            where: {taiKhoan: String(taiKhoan)}
        });

        if (findTaiKhoan.length > 0) {
            return res.status(404).json({message: 'Tài khoản đã tổn tài !'});
        };

        const findEmail = await prisma.user.findMany({
            where:{email: String(email)}
        });

        if (findEmail.length > 0) {
            return res.status(404).json({message: 'Email đã tồn tại !'});
        };

        const data = { taiKhoan, matKhau: authController.hashPass(matKhau), hoTen, soDT, email, maLoaiNguoiDung: String('')}

        const Newdata = await prisma.user.create({ data });

        res.status(200).json({data: Newdata, message: 'Tạo tài khoản thành công !'});

     
    } catch (err) {
        res.status(500).json(err);
    };
};



const loginUser = async (req, res) => {
    try {

        const {taiKhoan, matKhau} = req.body;
        
        const checkTaiKhoan = await prisma.user.findFirst({
            where: {taiKhoan: String(taiKhoan)},
        });

        if (checkTaiKhoan) {
            
            const checkMatKhau = await authController.comparePass(matKhau, checkTaiKhoan.matKhau);

            if(checkMatKhau) {

                const token = await authController.generateToken(checkTaiKhoan, '15h');
                

                return res.status(200).json({data: {token: token}, message: 'Đăng nhập thành công !'})
            }

        }else {
            return res.status(404).json({message: 'Tài khoảng không tồn tại !'});
        }

        

    } catch(err) {
        res.status(500).json(err);
    };
};

const getToken = async (req, res) => {
    try {


    } catch (err) {
        res.status(500).json(err);
    };
};



  ////////////////////////////////////////
 ///////           USER         /////////               
////////////////////////////////////////

const getAllUser = async (req, res) => {
    try {

        const data = await prisma.user.findMany({include: {user_type: true}});
       
       const newData = []
        for(let item of data) {
        let user = {
            maNguoiDung: item.maNguoiDung,
            taiKhoan: item.taiKhoan,
            matKhau: item.matKhau,
            hinhAnh: process.env.BASE_URL + item.hinhAnh,
            hoTen: item.hoTen,
            soDT: item.soDT,
            email: item.email,
            loaiNguoiDung: item.user_type.loaiNguoiDung
        }
         newData.push(user)
       }
        res.status(200).json({data:newData})

    } catch (err) {
        res.status(500).json(err);
    };
};

const getAUser = async (req, res) => {
    try {

    } catch (err) {
        res.status(500).json(err);
    };
};

const createUser = async (req, res) => {
    try {
       
        const { taiKhoan, matKhau, hoTen, soDT, email, maLoaiNguoiDung} = req.body;

        const { filename } = req.file;
        const image = filename

        const directoryPath = process.cwd() + '/public/avatar/';

      
        const findAccount = await prisma.user.findFirst({
            where: {taiKhoan: String(taiKhoan)}            
        });

        if (findAccount) {

            return res.status(404).json({message: "Tài Khoản Đã Tồn Tại !"});
           
        }

        const findEmail = await prisma.user.findFirst({
            where: {email: String(email)}
        });

        if (findEmail) {
            return res.status(404).json({message: 'Email đã tồn tại !'});
        };

        const findUserType = await prisma.user_type.findFirst({
            where:{maLoaiNguoiDung: String(maLoaiNguoiDung)}
        });

        if ( !findUserType ) {
            return res.status(404).json({message: 'Loại người dùng không tồn tại !'})
        }

        if( findAccount || findEmail || !findUserType ) {
            if(fs.existsSync(directoryPath + filename)) {
                fs.unlinkSync( directoryPath + filename)
            }
        }


        const newData = await prisma.user.create({
            data: {taiKhoan, matKhau: authController.hashPass(matKhau), hinhAnh: image, hoTen, soDT, email, maLoaiNguoiDung: maLoaiNguoiDung }
        })

        
        const data = {
            ...newData,
            hinhAnh: process.env.BASE_URL + '/public/avatar/' + newData.hinhAnh
        }

        res.status(200).json({data, message: 'Tạo tài Khoản Thành Công !'})

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateUser = async (req, res) => {
    try {

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteUser = async (req, res) => {
    try {

        const { maNguoiDung } = req.query;

        const find = await prisma.user.findFirst({where: {maNguoiDung: String(maNguoiDung)}})

        if(!find) {
            return res.status(404).json({message: "Không tìm thấy tài khoản !"})
        }

        await prisma.user.delete({where: {maNguoiDung: String(maNguoiDung)}});

        res.status(200).json({message: "Xóa thành công !"});

    } catch (err) {
        res.status(500).json(err);
    };
};



  ////////////////////////////////////////
 ///////      USER TYPE         /////////               
////////////////////////////////////////

const getAllUserType = async (req, res) => {
    try {

        const data = await prisma.user_type.findMany();

        res.status(200).json({data});

    } catch (err) {
        res.status(500).json(err);
    };
};

const getAUserType = async (req, res) => {
    try {

        const { maLoaiNguoiDung } = req.query;

        const data = await prisma.user_type.findUnique({
            where: {maLoaiNguoiDung: String(maLoaiNguoiDung)}
        });

        if (!data) {
            return res.status(404).json({message: 'Không Tìm Thấy Loại Người Dùng !'});
        }

        res.status(200).json({data})
        
    } catch (err) {
        res.status(500).json(err);
    };
};

const createUserType = async (req, res) => {
    try {


        const { loaiNguoiDung } = req.body;

        const find = await prisma.user_type.findFirst({
            where: {loaiNguoiDung: String(loaiNguoiDung)}
        });

        if(find) {
            return res.status(404).json({message: "Loại Người Dùng Đã Tồn Tại !"});
        }

        const data = await prisma.user_type.create({data: {loaiNguoiDung}});

        res.status(200).json({data, message: 'Thêm Loại Người Dùng Thành Công !'});

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateUserType = async (req, res) => {
    try {

        const { maLoaiNguoiDung } = req.query;
        const { loaiNguoiDung } = req.body;

        const data = await prisma.user_type.update({
            where: { maLoaiNguoiDung: String(maLoaiNguoiDung)},
            data: {loaiNguoiDung}
        });

        res.status(200).json({data, message: 'Cập Nhật Thành Công !'});

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteUserType = async (req, res) => {
    try {

        const { maLoaiNguoiDung } = req.query;

        const find = await prisma.user_type.findUnique({
            where: {maLoaiNguoiDung: String(maLoaiNguoiDung)},
        });
        console.log(find)

        if (!find) {
            return res.status(404).json({message:'Không Tìm Thấy Loại Người Dùng !'});
        }

        await prisma.user_type.delete({
            where:{maLoaiNguoiDung: String(maLoaiNguoiDung)},
        });
        
        res.status(200).json({message: 'Xóa Thành Công !'})

    } catch (err) {
        res.status(500).json(err);
    };
};


module.exports = {
    registerUser,
    loginUser,
    getToken,
    getAllUser,
    getAUser,
    createUser,
    updateUser,
    deleteUser,

/////// USER TYPE   ////////
    getAllUserType,
    getAUserType,
    createUserType,
    updateUserType,
    deleteUserType,

}